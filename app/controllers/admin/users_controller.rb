module Admin
  class UsersController < Admin::ApplicationController
    def find_resource(param)
      User.peers.from_slug(param)
    end

    def scoped_resource
      User.peers
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
