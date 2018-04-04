class Admin::ApplicationController < Admin::ResourcesController
  include WhitelabelDetection

  before_action :switch_label
end
