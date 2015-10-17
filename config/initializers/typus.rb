Typus.setup do |config|
  config.admin_title    = "OnRuby"
  config.authentication = :none
end

Admin::BaseController.instance_eval do
  include WhitelabelDetection

  before_filter :switch_label
end
