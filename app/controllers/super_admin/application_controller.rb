# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module SuperAdmin
  class ApplicationController < Administrate::ApplicationController
    include UserHandling
    include LocaleDetection
    include TimeZoneDetection

    helper all_helpers_from_path 'app/helpers'

    before_action :authenticate_super_admin_user!
    before_action :setup

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end


    private

    def setup
      switch_locale
      switch_time_zone
    end

    def order
      @order ||= Administrate::Order.new(
        params.fetch(resource_name, {}).fetch(:order, 'created_at'),
        params.fetch(resource_name, {}).fetch(:direction, 'desc'),
      )
    end

    def find_resource(param)
      scoped_resource.respond_to?(:from_param) ? scoped_resource.from_param(param) : scoped_resource.find(param)
    end

    def scoped_resource
      resource_class.unscoped
    end
  end
end
