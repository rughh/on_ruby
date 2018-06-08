class Admin::ApplicationController < Admin::ResourcesController
  include WhitelabelDetection

  prepend_before_action :debug_label

  private

  def debug_label
    Rails.logger.info("setting label")
    switch_label
    Rails.logger.info("setting label to #{Whitelabel[:label_id]}")
  end
end
