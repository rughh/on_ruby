class Admin::BaseAdminController < Admin::ResourcesController
  include WhitelabelDetection

  before_filter :switch_label
end