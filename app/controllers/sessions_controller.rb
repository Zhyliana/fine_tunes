class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @current_user = User.find_by_credentials(user_params)
    
    if @current_user.nil?
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
      return
    else
      login!(@current_user)
      redirect_to user_url(@current_user)
    end
  end
    
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil

    redirect_to new_session_url
  end
  
  # def login!(user)
  #   session[:token] = user.reset_session_token!
  #   @current_user = user
  # end
  # 
  # def redirect_logged_in
  #   redirect_to user_url if logged_in?
  # end

end
