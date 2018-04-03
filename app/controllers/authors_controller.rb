class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def create
    author = Author.new(author_params)
    if author.save
      redirect_to authors_path
    end
  end

  def show
    @author = Author.find(params[:id])
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    author = Author.find(params[:id])
    author.assign_attributes(author_params)
    if author.save
      redirect_to author_path(author)
    end
  end

  def destroy
    Author.destory(params[:id])
  end

  private
  def author_params
    return params.require(:author).permit(:name, :bio)
  end
end
