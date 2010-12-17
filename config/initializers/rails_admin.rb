require "rails_admin/application_controller"

module RailsAdmin
  class ApplicationController < ::ApplicationController
    before_filter :can_admin?
    
    private
    
    def can_admin?
      raise CanCan::AccessDenied if current_user.nil? || !current_user.admin?
    end
  end
end
