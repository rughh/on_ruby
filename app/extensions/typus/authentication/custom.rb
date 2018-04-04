module Typus
  module Authentication
    module Custom
      protected

      include Base
      include UserHandling

      def authenticate
        @admin_user = FakeUser.new

        authenticate_admin_user!
      end
    end
  end
end
