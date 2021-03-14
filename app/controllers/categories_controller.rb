class CategoriesController < ApplicationController
  before_action :set_category, only: %i(show update)
  before_action :authenticate_admin!, only: %i(new create update)
  
  layout :resolve_layout

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_path
    else
      render :new
    end
  end

  def show
    @courses = @category.courses.available
  end

  def update
    @category.update_attributes category_params
    redirect_to admin_path
  end

  def destroy
    @category.destroy
    redirect_to admin_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def resolve_layout
    case action_name
    when "show"
      "application"
    else
      "admin"
    end
  end
end
