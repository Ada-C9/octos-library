class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    # Rails form_for creates a nested param structure
    # This is fancy and good, but means we need to do
    # a little extra work.
    book = Book.new(book_params)

    # Could also say:
    # book.title = params[:book][:title]

    if book.save
      # redirect_to '/books'
      redirect_to books_path
    end
  end

  def show
    # Figure out which book the user wanted
    book_id = params[:id]

    # Load it from the DB
    # Save it in an instance variable for the view
    @book = Book.find(book_id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])

    # Or we can do it all together with assign_attributes
    book.assign_attributes(book_params)

    # Arbitrary rule: always use assign_attributes,
    # not update. This will pay off later.

    if book.save
      redirect_to book_path(book)
    end
  end

  def destroy
    # find it first
    # check the result of destroy

    Book.destroy(params[:id])

    redirect_to books_path
  end

  private
  def book_params
    return params.require(:book).permit(:title, :author_id, :synopsis, :publication_year)
  end
end
