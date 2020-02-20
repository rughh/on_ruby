module Admin
  class UsersController < Admin::ApplicationController
    def index
      super
      @resources = User.peers.page(params[:page]).per(10)
    end

    def find_resource(param)
      User.peers.find_by!(slug: param)
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
