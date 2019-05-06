module Admin
  class EventsController < Admin::ApplicationController
    def duplicate
      event = Event.duplicate!

      redirect_to [:edit, :admin, event], notice: 'Event duplicated!'
    end

    def connect
      event = find_resource(params[:id])
      topic = Topic.undone.find(params[:topic_id])
      topic.update! event: event
      event.particpate(topic.user)

      redirect_to [:admin, event], notice: 'Connected to Event!'
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
  end
end
