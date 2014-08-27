class SessionsController < ApplicationController

  def new
    @user = current_user
  end

  def create
    @user = User.find_by username: params[:session][:username]
    if @user.nil?
      flash[:error] = "User not found"
      redirect_to signin_path
    else
      signin @user
      redirect_to user_path(@user)
    end
  end

  def destroy
    signout
    flash[:success] = "You have been signed out"
    redirect_to signin_path
  end

end