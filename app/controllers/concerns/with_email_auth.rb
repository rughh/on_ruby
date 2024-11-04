# frozen_string_literal: true

# Based on https://github.com/weg-li/weg-li/blob/master/app/controllers/sessions_controller.rb
# Original author: https://github.com/phoet

module WithEmailAuth
  def email; end

  def email_login
    email = normalize_email(params[:email])
    if email.present? && valid_looking_email?(email)
      token = EmailAuthToken.generate(email)
      label_name = t("label.#{Whitelabel[:label_id]}.name")
      label_link = Whitelabel[:canonical_url]
      UserMailer.login_link(email, token, I18n.locale,
                            label_name, label_link).deliver_later

      redirect_to root_path, notice: t('email_auth.email_sent', email:)
    else
      flash.now[:alert] = t('email_auth.invalid_email')

      render :email, status: :unprocessable_entity
    end
  end

  protected

  def normalize_email(email)
    email.to_s.strip.downcase
  end

  def valid_looking_email?(email)
    email.match(/\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i)
  end
end
