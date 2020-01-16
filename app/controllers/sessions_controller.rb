class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by username: params[:session][:username].downcase
    if @user
      log_in @user
      redirect_to :root
    else
      flash.now[:danger] = 'Username not found'
      render :new
    end
  end

  def destroy
    log_out(current_user) if logged_in?
    redirect_to :root
  end
end
