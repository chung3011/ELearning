class UserExamsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_exam, only: %i(show update)
  MAX_POINT = 10

  def create
    @user_exam = current_user.user_exams.build(lesson_id: params[:lesson_id])
    if @user_exam.save
      redirect_to user_exam_path @user_exam
    end
  end

  def show
    @lesson = @user_exam.lesson
    @questions = @lesson.questions
    @user_answer = @user_exam.user_answers.build
  end

  def update
    @user_exam.update_attributes user_exam_params
    @user_exam.point = exam_point
    @user_exam.save
    redirect_to exam_list_path
  end

  def result
    @user_exam = current_user.user_exams.find_by(id: params[:id])
    @lesson = @user_exam.lesson
    @questions = @lesson.questions
  end

  private

  def set_user_exam
    @user_exam = current_user.user_exams.find(params[:id])
  end

  def user_exam_params
    params.require(:user_exam).permit(:user_id, :lesson_id, user_answers_attributes: [ :answer_id, :user_exam_id ])
  end

  def exam_point
    answers = @user_exam.answers
    point = answers.sum {|p| p.point}
    (point.to_f/answers.size * MAX_POINT).ceil
  end
end
