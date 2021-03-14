class CourseCommentsController < ApplicationController
  before_action :authenticate!

  def create
    @course_comment = current_user.course_comments.build comment_params
    respond_to do |format| 
      if @course_comment.save
        @course = @course_comment.course
        flash[:success] = 'Comment posted'
        format.js
      end
    end
  end

  def destroy
    @course_comment = CourseComment.find_by(id: params[:id])
    @course = @course_comment.course
    @course_comment.destroy
    flash[:success] = 'Comment deleted'
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:course_comment).permit(:course_id, :content)
  end
end
