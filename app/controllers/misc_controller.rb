class MiscController < ApplicationController
  respond_to :xml
  layout :false

  def trigger_error
    data = {:data => {:message => "was doing something wrong"}}
    error = ExceptionNotifier::Notifier.exception_notification(request.env, Exception.new, data)
    error.deliver
  end

  def sitemap; end
end
