class SessionsController < ApplicationController
  # log in page
  def new
    render :new
  end

  # log in
  def create
    @user = User.find_by_credentials(session_params)
    if @user
      session[:session_token] = @user.reset_token
      redirect_to cats_url
    else

    end

  end

  def destroy
  end

  def session_params
    params.require(:user).permit(:user_name, :password)
  end
end
