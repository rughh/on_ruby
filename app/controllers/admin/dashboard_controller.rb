class Admin::DashboardController < Admin::BaseController
  include WhitelabelDetection

  before_filter :switch_label
end
