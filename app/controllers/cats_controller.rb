class CatsController < ApplicationController

  before_action :correct_user?, only: [:edit, :update]

  def correct_user?
    @cat = Cat.find(params[:id])
    @cat.owner.id == current_user.id ? true : redirect_to(cats_url)
  end

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    req_params = params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex, :owner_id)
    req_params[:user_id] = current_user.id
    req_params
  end
end
