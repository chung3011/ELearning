class UserCoursesController < ApplicationController
  before_action :set_user_course, only: %i(destroy)
  before_action :logged_in_user
  
  def new
    @user_course = UserCourse.new 
  end

  def create
    @user_course = current_user.user_courses.build(course_id: params[:course_id])
    if @user_course.save
      course = @user_course.course
      flash[:info] = t(".success")
      redirect_to course
    else
      flash[:danger] = @user_course.errors.full_messages.first
      redirect_to root_path
    end
  end

  def destroy
    @user_course.destroy
    flash[:info] = t(".delete")
    redirect_to courses_list_path
  end

  private
  
  def set_user_course
    @user_course = current_user.user_courses.find(params[:id])
  end
end
