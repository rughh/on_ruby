module Admin
  class EventsController < Admin::ApplicationController
    before_action :set_default_order

    def duplicate
      event = Event.duplicate!

      redirect_to [:edit, :admin, event]
    end

    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Event.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Event.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    private

    def set_default_order
      logger.info "YES HELLO"
      resource_params = params.fetch(resource_name, {})
      order = resource_params.fetch(:order, "date")
      direction = resource_params.fetch(:direction, "desc")
      params[resource_name] = resource_params.merge(order: order, direction: direction)
    end

  end
end
