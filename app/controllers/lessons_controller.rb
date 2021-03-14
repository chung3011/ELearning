class LessonsController < ApplicationController
  before_action :set_lesson, only: %i(show edit update destroy)
  before_action :authenticate_admin!, only: %i(create update destroy)

  layout "admin"

  def new
    @lesson = Lesson.new
    @lesson.questions.build.answers.build
  end

  def create
    @lesson = Lesson.new lesson_params
    course = @lesson.course
    @lesson.sequence = course.lessons.maximum("sequence") + 1
    if @lesson.save
      redirect_to admin_course_info_path(id: course.id)
    else
      render :new
    end
  end

  def edit
    @course = @lesson.course
  end

  def update
    if @lesson.update_attributes lesson_params
      course = @lesson.course
      redirect_to admin_course_info_path(id: course.id)
    end
  end

  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :description, :video, :course_id, questions_attributes: [:id, :content, :_destroy, answers_attributes:[:id, :content, :point, :_destroy]])
  end
end
