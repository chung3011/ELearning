class TagsController < ApplicationController
  before_action :set_tag, only: %i(index show update destroy)
  before_action :authenticate_admin!, only: %i(new create update destroy)

  layout :resolve_layout
  
  def index
    @courses = @tag.courses.available.includes(:category)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new tag_params
    if @tag.save
      redirect_to admin_path
    else
      render :new
    end
  end

  def show
    @course_tags = @tag.course_tags.includes(:course)
    @follow_tags = @tag.follow_tags.includes(:user)
  end

  def update
    @tag.update_attributes tag_params
    redirect_to admin_path
  end

  def destroy
    @tag.destroy
    redirect_to admin_path
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

  def resolve_layout
    case action_name
    when "index"
      "application"
    else
      "admin"
    end
  end
end
