class PasswordResetsController < ApplicationController
  before_action :set_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by mail: params[:password_reset][:mail].downcase

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Mail not found"
      render :new
    end
  end

  def edit; end

  def update
    @user.update_attributes user_params
    log_in @user
    @user.update_attribute :reset_digest, nil
    flash[:success] = "Password has been reset."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def set_user
    @user = User.find_by mail: params[:mail]

    return if @user
    flash[:danger] = "User not found"
    redirect_to root_path
  end

  def valid_user
    return if @user.activated? && @user.valid_token?(:reset, params[:id])
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = "Password reset has expired."
    redirect_to new_password_reset_url
  end
end
