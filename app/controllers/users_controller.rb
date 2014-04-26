class UsersController < ApplicationController
  
  def index
    @users = Users.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
   @user = User.new(user_params)

   if @user.try(:save)
     login!(@user)
     redirect_to user_url(@user)
   else
     flash.now[:errors] = @user.errors.full_messages
     render :new
   end
  end

  private
  def user_params
   params.require(:user).permit(:email, :password_digest)
  end
end
