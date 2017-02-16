class UsersController < ApplicationController

  def new
    @action = :user
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user
      redirect_to user_url(@user)
    else
      redirect_to new_user_url
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
