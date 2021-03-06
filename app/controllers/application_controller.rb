class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_locale, :listing_categories

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t(".login")
    redirect_to login_url
  end

  def authenticate!
    return if logged_in? || admin_signed_in?
  end

  def listing_categories
    @categories = Category.all
  end
end
