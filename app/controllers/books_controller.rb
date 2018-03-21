class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new; end

  def create
    book = Book.new(title: params[:my_title], author: params[:author])
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
  end

  def update
  end

  def destroy
  end
end
