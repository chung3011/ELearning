class CoursesController < ApplicationController
  before_action :set_course, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(show)
  before_action :authenticate_admin!, only: %i(create update destroy)
  
  layout :resolve_layout

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      redirect_to admin_course_info_path(id: @course.id)
    else
      render :new
    end
  end

  def show
    @lessons = @course.lessons.by_sequence
    @tags = Tag.by_course(@course.id)
    @comments = @course.course_comments.newest
    @course_comment = CourseComment.new
    @rates = @course.course_rates
    @course_rate = CourseRate.new
  end

  def edit; end

  def update
    if @course.update_attributes course_params
      redirect_to admin_course_info_path(id: @course.id)
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :category_id, :available, lessons_attributes: [:id, :name, :sequence])
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
