class MobileController < ApplicationController
  skip_before_filter :switch_label, only: [:settings]

  def index; end
  def settings; end
end
