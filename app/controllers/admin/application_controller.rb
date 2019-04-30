# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include WhitelabelDetection
    include UserHandling

    # prepend_before_action :switch_label
    before_action :switch_label
    before_action :authenticate_admin_user!

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    def find_resource(param)
      klazz = resource_name.to_s.classify.constantize
      klazz.respond_to?(:from_param) ? klazz.from_param(param) : klazz.find(param)
    end
  end
end
