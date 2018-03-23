class Admin::ApplicationController < Admin::ResourcesController
  include WhitelabelDetection

  before_filter :switch_label
end
