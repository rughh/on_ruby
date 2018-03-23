class Admin::UsersController < Admin::ApplicationController
  def new
    redirect_to url_for(controller: '/admin/users'), notice: "You can't create users via the admin, they need to signup via OAuth!"
  end
end
