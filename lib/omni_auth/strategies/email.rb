# frozen_string_literal: true

# Based on https://github.com/weg-li/weg-li/blob/master/app/lib/omni_auth/strategies/email.rb
# Original author: https://github.com/phoet

require 'base64'
require 'English'

module OmniAuth
  module Strategies
    class Email
      include OmniAuth::Strategy

      def request_phase
        redirect '/sessions/email'
      end

      def callback_phase
        token = request.params['token']
        fail!(:authenticity_error) if token.blank?

        begin
          decoded_token = EmailAuthToken.decode(token)
        rescue StandardError
          fail!(:authenticity_error, $ERROR_INFO)
        end

        @email = decoded_token['iss'].to_s.downcase
        fail!(:authenticity_error) if @email.blank?

        super
      end

      uid { Digest::SHA256.new.hexdigest(@email) }

      info { { 'email' => @email } }
    end
  end
end
