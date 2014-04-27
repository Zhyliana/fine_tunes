class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
   @user = User.new(user_params)
   @user.save
   
   if @user.try(:save)
     login!(@user)
     redirect_to user_url(@user)
   else
     flash.now[:errors] = ["New user NOT created."]
     render :new
   end
  end
  
end 
