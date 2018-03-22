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
    raw_book = params[:book]

    book = Book.new
    book.title = raw_book[:title]
    book.author = raw_book[:author]
    book.publication_date = raw_book[:publication_date]
    book.synopsis = raw_book[:synopsis]

    # Could also say:
    # book.title = params[:book][:title]

    if book.save
      redirect_to '/books'
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
    raw_book = params[:book]

    book = Book.find(params[:id])

    # We could follow the same pattern from create
    # book.title = raw_book[:title]
    # book.author = raw_book[:author]
    # book.publication_date = raw_book[:publication_date]
    # book.synopsis = raw_book[:synopsis]

    # Or we can do it all together with assign_attributes
    book.assign_attributes(
      title: raw_book[:title],
      author: raw_book[:author],
      publication_date: raw_book[:publication_date],
      synopsis: raw_book[:synopsis]
    )

    # Arbitrary rule: always use assign_attributes, not
    # update. This will pay off later.

    if book.save
      redirect_to book_path(book)
    end
  end

  def destroy
  end
end
