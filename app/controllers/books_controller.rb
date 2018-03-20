class BooksController < ApplicationController
  def index
    # Placeholder book data until we get models tomorrow!
    # @my_string = "yelling"

    @books = Book.all
  end

  def new
  end

  def create
  end

  def show
    # Figure out which book the user wanted
    book_id = params[:id]


    # Load it from the DB
    # Save it in an instance variable for the view
    @book = Book.find(book_id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
