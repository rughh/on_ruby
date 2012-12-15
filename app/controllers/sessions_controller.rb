class SessionsController < ApplicationController
  def offline_login
    self.current_user = User.find_by_nickname(params[:nickname])
    redirect_to root_path, notice: "Offline Login!"
  end

  def create
    authorization = Authorization.handle_authorization request.env['omniauth.auth']
    self.current_user = authorization.user
    cookies.permanent.signed[:remember_me] = [current_user.id, current_user.salt]
    redirect_to request.env['omniauth.origin'] || root_path, notice: t("flash.logged_in", nickname: current_user.nickname)
  end

  def destroy_user_session
    redirect_to destroy_session_path
  end

  def destroy
    session[:user_id] = nil
    cookies.permanent.signed[:remember_me] = ['', '']
    redirect_to root_path, notice: t("flash.logged_out")
  end

  def failure
    redirect_to root_path, alert: t("flash.login_error")
  end

  def auth
    session[:omniauth_keys] = Usergroup.omniauth_keys(params[:provider], request)
    redirect_to "/auth/#{params[:provider]}"
  end
end
