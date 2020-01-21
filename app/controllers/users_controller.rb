class UsersController < ApplicationController
  before_action :user_logged_in?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = 'User created successfully'
      redirect_to :root
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end
end
