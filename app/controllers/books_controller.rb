class BooksController < ApplicationController
  def index
    # Placeholder book data until we get models tomorrow!
    # @my_string = "yelling"

    @books = [
      { title: "Hidden Figures", author: "Margot Lee Shetterly"},
      { title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz"},
      { title: "Kindred", author: "Octavia E. Butler"},
      { title: "Uncreative", author: "Book"}
    ]
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
    @book = { title: "The left hand of darkness", author: "Ursula K. Le Guin"}
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
