class SessionsController < ApplicationController

  def new
    @author = Author.new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
      if @user.nil?
        # User doesn't match anything in the DB
        # Attempt to create a new user
        @user = User.new(
          name: auth_hash['info']['name'],
          email: auth_hash['info']['email'],
          uid: auth_hash['uid'],
          provider: auth_hash['provider'])
        if @user.save
          # saved successfully
          session[:user_id] = @user.id
          flash[:success] = "Logged in successfully"
          redirect_to root_path
        else
          # not saved successfully
          flash[:error] = "Could not log in"
          redirect_to root_path
        end

      else
        session[:user_id] = @user.id
        flash[:success] = "Logged in successfully"
        redirect_to root_path
      end
    else
      flash[:error] = "Could not log in"
      redirect_to root_path
    end

    # author = Author.find_by(name: params[:author][:name])
    #
    # if author
    #   session[:author_id] = author.id
    #   flash[:success] = "#{ author.name } is successfully logged in."
    #   redirect_to root_path
    # else
    #   # other logic that does more stuff
    # end
  end

  def destroy
    # session[:author_id] = nil
    session.delete(:user_id)
    flash[:success] = "Logged out successfully."

    redirect_to root_path
  end

end
