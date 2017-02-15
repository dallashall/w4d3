class SessionsController < ApplicationController

  before_action :logged_out?, only: [:create, :new]
  # log in page
  def new
    render :new
  end

  # log in
  def create
    @user = User.find_by_credentials(session_params)
    login_user if @user
    redirect_to :index
  end

  def destroy
    current_user.reset_token!
    session[:session_token] = nil
  end

  def session_params
    params.require(:user).permit(:user_name, :password)
  end


end
