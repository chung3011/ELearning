class AdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_course, only: %i(course_info)
  before_action :set_user, only: %i(user_info)

  layout "admin"

  def index
    @users = User.with_deleted
    @courses = Course.all
    @categories = Category.all
    @tags = Tag.all
    @course = Course.new
  end

  def user_info
    @courses = @user.courses.includes(:lessons)
  end

  def course_info
    @lessons = @course.lessons.by_sequence.includes(questions: :answers).includes(:user_exams)
    @user_courses = @course.user_courses.includes(:user)
    @comments = @course.course_comments.includes(:user)
    @tags = @course.tags
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
