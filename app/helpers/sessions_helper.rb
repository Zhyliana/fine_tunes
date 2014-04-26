module SessionsHelper

  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end
  
  def log_in_user!(user)
    session[:session_token] = user.reset_session_token! 
    @current_user = user
  end
  
  def logged_in?
    !!current_user
  end
  
end