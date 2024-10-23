# frozen_string_literal: true

# Based on https://github.com/weg-li/weg-li/blob/master/app/mailers/user_mailer.rb
# Original author: https://github.com/phoet

class UserMailer < ApplicationMailer
  def login_link(email, token, from, locale, label_name, label_link) # rubocop:disable Metrics/ParameterLists
    @token = token
    @from = from
    @label_name = label_name
    @label_link = label_link

    I18n.with_locale(locale) do
      mail from: @from, to: email, subject: t('email_auth.subject', label: label_name)
    end
  end
end
