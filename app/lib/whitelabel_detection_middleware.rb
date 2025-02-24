# frozen_string_literal: true

class WhitelabelDetectionMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    Whitelabel.reset!
    request = ActionDispatch::Request.new(env)
    Whitelabel.label = detect_label(request)
    Appsignal.add_tags(label: Whitelabel.label.label_id)
    @app.call(env)
  end

  private

  def detect_label(request)
    Whitelabel.label_for(request.subdomains.first).tap { |label| return label unless label.nil? }

    Whitelabel.labels.find do |label|
      label.domains&.any? do |custom_domain|
        return label if request.host =~ /#{custom_domain}/
      end
    end

    Whitelabel.labels.first
  end
end
