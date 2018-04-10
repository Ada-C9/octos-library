class SessionsController < ApplicationController

  def new
    @author = Author.new
  end

  def create
    author = Author.find_by(name: params[:author][:name])

    if author
      session[:author_id] = author.id
      flash[:success] = "#{ author.name } is successfully logged in."
      redirect_to root_path
    else
      # other logic that does more stuff
    end
  end

  def destroy
    # session[:author_id] = nil
    session.delete(:author_id)
    flash[:success] = "Logged out successfully."

    redirect_to root_path
  end

end
