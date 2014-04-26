class SessionsController < ApplicationController
  before_action :redirect_logged_in
  
  def create
    #finds user
    @current_user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password])
    
    if @current_user.nil?
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
      return
    else
      login!(@current_user)
      redirect_to users_url
    end
    
    def destroy
      current_user.reset_session_token!
      session[:session_token] = nil

      redirect_to new_session_url
    end
    
    def new
      render :new
    end
    
    # #generates session token for user
   #  @current_user.session_token = User.generate_session_token
   #  @curent_user.save
   #  # put the generated token in the client's cookies
   #  session[:session_token] =  @current_user.session_token 
   #  
   #  #redirects user to their own "profile"
   #  redirect_to user_url(@current_user.id) 
  end
  
  def login!(user)
    session[:token] = user.reset_session_token!
    @current_user = user
  end
  def redirect_logged_in
    redirect_to user_url if logged_in?
  end

end
