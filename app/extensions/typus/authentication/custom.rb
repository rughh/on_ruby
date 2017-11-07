module Typus
  module Authentication
    module Custom
      protected

      include Base
      include UserHandling

      def authenticate
        @admin_user = FakeUser.new
        def @admin_user.can?(*args)
          action, type, _ = args
          return false if action == 'create' && type == 'User'
          return true
        end
        authenticate_admin_user!
      end
    end
  end
end
