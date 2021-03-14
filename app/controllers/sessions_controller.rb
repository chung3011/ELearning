class SessionsController < ApplicationController
  def new
  end

  def create
    session = params[:session]
    user = User.find_by mail: session[:mail].downcase

    if user&.authenticate session[:password]
      check_activated user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "You are logged out"
    redirect_to root_path
  end

  def google_auth
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    if user.present?
      log_in user
      user.google_token = access_token.credentials.token
      refresh_token = access_token.credentials.refresh_token
      user.google_refresh_token = refresh_token if refresh_token.present?
      user.save
      redirect_to root_path
    else
      flash.now[:danger] = "You cant sign in with this email account"
      render :new
    end
  end

  private

  def check_remember user
    if params[:session][:remember_me] == "1"
      remember user
    else
      forget user
    end
  end

  def check_activated user
    if user.activated?
      flash[:success] = "Login success"
      log_in user
      check_remember user
      redirect_to profile_path
    else
      flash[:warning] = "Account not activated!"
      redirect_to root_path
    end
  end
end
