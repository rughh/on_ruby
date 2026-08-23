# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include LocaleDetection
  include TimeZoneDetection
  include UserHandling

  protect_from_forgery with: :exception

  before_action :setup

  helper_method :signed_in?, :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :_404
  rescue_from ActionView::MissingTemplate, with: :_404
  rescue_from ActionController::UnknownFormat, with: :_404
  rescue_from ActionController::BadRequest, with: :_400
  rescue_from ActionController::InvalidAuthenticityToken, with: :_422

  expose(:jobs)       { Job.shuffled }
  expose(:highlights) { Highlight.active }

  protected

  def setup
    switch_locale
    switch_time_zone
  end

  def _400(exception)
    Rails.logger.warn "400 bad_request: #{exception.message} — #{request.method} #{request.path} (#{request.remote_ip})"
    head(:bad_request)
  end

  def _422
    head(:unprocessable_entity)
  end

  def _404(exception)
    Rails.logger.warn exception
    Rails.logger.warn "head 404 with params #{params}"

    head(:not_found)
  end
end
