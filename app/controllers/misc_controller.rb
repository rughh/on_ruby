class MiscController < ApplicationController
  respond_to :xml
  layout :false

  def trigger_error
    data = {:data => {:message => "was doing something wrong"}}
    error = ExceptionNotifier::Notifier.exception_notification(request.env, Exception.new, data)
    error.deliver
    render text: "ERROR DELIVERED"
  end

  def sitemap; end
end
