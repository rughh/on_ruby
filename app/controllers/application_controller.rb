class ApplicationController < ActionController::Base
  include MobileDetection
  include LocaleDetection
  include UserHandling

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  protect_from_forgery

  before_filter :setup

  helper_method :signed_in?, :current_user
  helper_method :mobile_device?

  rescue_from ActiveRecord::RecordNotFound, with: :_404
  rescue_from ActionView::MissingTemplate,  with: :_404

  expose(:jobs)       { Job.shuffled }
  expose(:main_user)  { User.main }
  expose(:highlights) { Highlight.active }

  def check_login
    redirect_to(auth_path) unless signed_in?
  end

  protected

  def setup
    reset_thread_locales
    switch_label
    switch_locale
    check_for_mobile
  end

  def reset_thread_locales
    Whitelabel.reset!
    I18n.locale = I18n.default_locale
  end

  def switch_label
    unless Usergroup.switch_by_request(request)
      redirect_to labels_url(subdomain: 'www')
    end
  end

  def _404(exception)
    Rails.logger.warn exception
    Rails.logger.warn "head 404 with params #{params}"
    head 404
  end
end
