class UserLessonsController < ApplicationController
  before_action :set_user_lesson, only: %i(destroy)
  before_action :logged_in_user
  
  def new
    @user_lesson = UserLesson.new
  end

  def create
    @user_lesson = current_user.user_lessons.build(lesson_id: params[:lesson_id])
    respond_to do |format|
      if @user_lesson.save
        @lesson = @user_lesson.lesson
        @course = @lesson.course
        format.js
      end
    end
  end

  def destroy
    @user_lesson.destroy
    flash[:info] = t (".delete")
    redirect_to root_path
  end

  private
  
  def set_user_lesson
    @user_lesson = current_user.user_lessons.find(params[:id])
  end
end
