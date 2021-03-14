class AccountActivationController < ApplicationController
  def edit
    user = User.find_by mail: params[:mail]

    if user && !user.activated? && user.valid_token?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Activated"
      redirect_to profile_path
    else
      flash[:danger] = "Invalid link"
      redirect_to root_url
    end
  end
end
