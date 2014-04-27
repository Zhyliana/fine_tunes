class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(user_params)
  end

  def new
    @user = User.new
  end

  def create
   @user = User.new(user_params)
   
   if @user.try(:save)
     login!(@user)
     redirect_to bands_url
   else
     flash.now[:errors] = ["New user NOT created."]
     render :new
   end
  end
    
end 
