class UsersController < ApplicationController

  def create
   @user = User.new(user_params)

   if @user.save
     #login_user!(@user)
     login!(@user)
     # flash.now[:notice] = '"#{@user.email}" has been added to our users list!'
     #redirect_to cats_url
     redirect_to user_url(@user.id)
   else
     flash.now[:notice] = '"#{@user.email}" has NOT been added to our users list!'
     render :new
   end
  end
  
  
  def new
    @user = User.new
    @user.save
    # @user.class.generate_session_token
  
    render :new
  end

   private
   def user_params
     params.require(:user).permit(:email, :password_digest)
   end
end
