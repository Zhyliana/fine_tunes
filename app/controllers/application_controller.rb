class ApplicationController < ActionController::Base
  helper_method :logged_in?, :logout, :session_user, :login!

  def login!(user)
    session[:token] = user.reset_session_token!
    @current_user = user
  end
  def current_user
    @current_user  ||= User.find_by_session_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def logout
    current_user.try(:reset_session_token!)
  end

end