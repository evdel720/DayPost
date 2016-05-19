class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_i18n_locale_from_params
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:alert] = "#{params[:locale]} translation is not available."
        logger.error flash.now[:alert]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private
  def not_authorized
    redirect_to root_path, alert: I18n.t('.not_allowed')
  end
end
