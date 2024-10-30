# frozen_string_literal: true

class SessionsController < ApplicationController
  include WithEmailAuth

  def offline_login
    user = User.find_by(nickname: params[:nickname])
    sign_in(user)

    redirect_to root_path, notice: 'Offline Login!'
  end

  def index; end

  def create
    begin
      authorization = Authorization.handle_authorization(current_user, request.env['omniauth.auth'])
      sign_in(authorization.user)
      user_name = current_user.missing_name? ? '' : current_user.name
      options = { notice: t('flash.logged_in', name: user_name) }
    rescue User::DuplicateNickname => e
      options = { alert: t('flash.duplicate_nick', name: e.nickname) }
    end

    redirect_to request.env['omniauth.origin'].presence || root_path, options
  end

  def destroy
    sign_out

    redirect_to root_path, notice: flash[:notice] || t('flash.logged_out')
  end

  def failure
    redirect_to root_path, alert: t('flash.login_error')
  end
end
