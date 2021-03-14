class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create destroy)
  before_action :authenticate_admin!, only: %i(destroy)

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    mail = user_params[:mail]
    user_check = User.with_deleted.find_by mail: mail
    if user_check.nil?
      @user = User.new user_params
      if @user.save
        @user.send_activation_email
        flash[:info] = "Check your mail to activate account"
        redirect_to root_path
      else
        flash[:danger] = "Register failed"
        render :new
      end
    else
      flash[:danger] = "You cant sign up with this email"
      redirect_to root_path
    end
  end

  def update
    if current_user.update_attributes user_params
      flash[:success] = "Update success"
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find id: params[:id]
    @user.destroy
    redirect_to admin_path
  end

  def course_list
    @courses = current_user.courses.available
  end

  def exam_list
    @user_exams = current_user.user_exams.order("created_at desc").includes(lesson: :course)
  end

  private

  def user_params
    params.require(:user).permit :name, :mail, :password,
    :password_confirmation
  end

end
