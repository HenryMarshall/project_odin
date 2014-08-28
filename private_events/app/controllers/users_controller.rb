class UsersController < ApplicationController
  # user must not be logged in to create new user

  def new
    @user = User.new
  end

  def create
    @user = User.new(username: params[:user][:username])
    if @user.save
      flash[:success] = "Created account"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Could not save" 
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end