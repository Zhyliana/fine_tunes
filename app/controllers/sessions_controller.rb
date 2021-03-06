class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @current_user = User.find_by_credentials(user_params)
    
    if @current_user
      login!(@current_user)
      redirect_to user_url(@current_user)
    else
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    end
  end
    
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil

    redirect_to new_session_url
  end

end
