class FollowTagsController < ApplicationController
  before_action :set_follow_tag, only: %i(destroy)
  before_action :logged_in_user

  def index
    @tags = current_user.tags
    course_ids = CourseTag.by_ids(current_user.tag_ids).pluck(:course_id)
    @courses = Course.by_ids(course_ids)
  end

  def new
    @follow_tag = FollowTag.new 
  end

  def create
    @follow_tag = current_user.follow_tags.build(tag_id: params[:tag_id])
    if @follow_tag.save
      flash[:info] = t(".success")
      redirect_to follow_tags_path
    else
      flash[:danger] = @follow_tag.errors.full_messages.first
      redirect_to root_path
    end
  end

  def destroy
    @follow_tag.destroy
    flash[:info] = t(".delete")
    redirect_to follow_tags_path
  end

  private
  
  def set_follow_tag
    @follow_tag = current_user.follow_tags.find(params[:id])
  end
end
