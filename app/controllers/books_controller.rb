class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]

  # Use a controller filter to manage authorization
  # require_login comes from the ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    if params[:author_id]
      # Have an author id
      @author = Author.find(params[:author_id])
      @books = @author.books
      # - or -
      # @books = Book.where(author_id: params[:author_id])
    else
      # No author, load all the books
      # This is our old, non-nested version
      @books = Book.all
    end
  end

  def new
    @book = Book.new(author_id: params[:author_id])
  end

  def create
    # Rails form_for creates a nested param structure
    # This is fancy and good, but means we need to do
    # a little extra work.
    @book = Book.new(book_params)

    # Could also say:
    # book.title = params[:book][:title]

    if @book.save
      # redirect_to '/books'
      flash[:success] = "Book added successfully"
      redirect_to books_path
    else
      # Validations failed! What do we do?
      # This flash message is redundant but for demonstration purposes
      flash.now[:failure] = "Validations Failed"
      render :new, status: :bad_request
    end
  end

  def show; end

  def edit; end

  def update
    # Or we can do it all together with assign_attributes
    @book.assign_attributes(book_params)

    # Arbitrary rule: always use assign_attributes,
    # not update. This will pay off later.

    if @book.save
      redirect_to book_path(@book)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    # find it first
    # check the result of destroy
    @book.destroy

    redirect_to books_path
  end

  private

  def book_params
    return params.require(:book).permit(:title, :author_id, :synopsis, :publication_year, genre_ids: [])
  end

  def find_book
    # use find_by(id:) instead of find
    # @book will be nil if the find_by failed
    @book = Book.find_by(id: params[:id])
    # head is similar to render, except it doesn't run
    #   a view template, so the browser only gets the status code
    # This is not the only thing you can do in this scenario
    #   but it is the simplest
    head :not_found unless @book
  end
end
