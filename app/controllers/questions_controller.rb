class QuestionsController < ApplicationController
  before_action :set_question, only: %i(edit update)
  before_action :authenticate_admin!, only: %i(new create edit update)

  def new
    @question = Question.new
    @question.answers.build
  end

  def edit
    @lesson = @question.lesson
  end
  
  def create
    @question = Question.new question_params
    if @question.save
      course = @question.lesson.course
      redirect_to admin_course_info_path(id: course.id)
    else
      render :new
    end
  end

  def update
    @question.update_attributes question_params
    course = @question.lesson.course
    redirect_to admin_course_info_path(id: course.id)
  end

  private

  def set_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit(:content, :lesson_id, answers_attributes: [:id, :content, :point, :_destroy])
  end
end
