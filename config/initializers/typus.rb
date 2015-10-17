Typus.setup do |config|
  config.admin_title      = "OnRuby"
  config.user_class_name  = "User"
  config.authentication   = :custom
end

Admin::BaseController.instance_eval do
  include WhitelabelDetection

  before_filter :switch_label
end
