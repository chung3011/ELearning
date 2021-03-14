class CourseRatesController < ApplicationController
  before_action :set_course_rate, only: %i(destroy)
  before_action :logged_in_user

  def create
    @course_rate = current_user.course_rates.build rate_params
    respond_to do |format| 
      if @course_rate.save
        @course = @course_rate.course
        flash[:success] = 'Rated'
        format.js
      end
    end
  end

  def destroy
    @course = @course_rate.course
    @course_rate.destroy
    flash[:success] = 'Rate deleted'
    respond_to do |format|
      format.js
    end
  end

  private

  def set_course_rate
    @course_rate = current_user.course_rates.find(params[:id])
  end

  def rate_params
    params.require(:course_rate).permit(:course_id, :point)
  end
end
