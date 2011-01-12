require "rails_admin/application_controller"

RailsAdmin.authenticate_with {}

module RailsAdmin
  class ApplicationController < ::ApplicationController
    before_filter :can_admin?

    private

    def can_admin?
      raise CanCan::AccessDenied if current_user.nil? || !current_user.admin?
    end
  end

  DEFAULT_CURRENT_USER = Proc.new do
    #return nil unless resource = Devise::mappings.keys.first {|r| signed_in?(r)}
    send("current_user")
  end
end

