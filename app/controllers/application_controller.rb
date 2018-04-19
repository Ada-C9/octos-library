class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private
  # Check that the user is logged in, and send back
  # an error if they are not
  # Store the looked-up user in @user in case
  # someone wants to use it later.
  # We write this method here so it will be available
  # in _all_ controllers
  def require_login
    @user = User.find_by(id: session[:user_id])
    head :unauthorized unless @user
  end
end
