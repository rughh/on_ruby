class SessionsController < ApplicationController
  def offline_login
    self.current_user = User.find_by_nickname(params[:nickname])
    redirect_to root_path, :notice => "Offline Login!"
  end

  def create
    auth = request.env['omniauth.auth']
    logger.info "logging in with auth='#{auth}'"
    unless @auth = Authorization.find_from_hash(auth)
      @auth = Authorization.create_from_hash auth, current_user
    end
    @auth.user.update_from_auth! auth
    self.current_user = @auth.user
    cookies.permanent.signed[:remember_me] = [@auth.user.id, @auth.user.salt]
    redirect_to request.env['omniauth.origin'] || root_path, :notice => "Hi #{current_user.name}, du bist erfolgreich eingeloggt!"
  end

  def destroy_user_session
    redirect_to destroy_session_path
  end

  def destroy
    session[:user_id] = nil
    cookies.permanent.signed[:remember_me] = ['', '']
    redirect_to root_path, :notice => 'Du bist erfolgreich ausgeloggt!'
  end

  def failure
    redirect_to root_path, :alert => 'Fehler beim Einloggen mit Twitter, bist du dort vielleicht nicht eingeloggt?'
  end

  def auth
    redirect_to "/auth/#{params[:provider]}"
  end

end
