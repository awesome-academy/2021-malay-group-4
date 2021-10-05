class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :switch_locale

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t(:loginpls)
      redirect_to login_url
    end
  end

  def switch_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
