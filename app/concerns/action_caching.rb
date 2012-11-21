require 'active_support/concern'

module ActionCaching
  extend ActiveSupport::Concern

  module ClassMethods
    def caches_action_condition(controller)
      !controller.request.format.mobile?
    end

    def caches_action_cache_path(controller)
      format = controller.request.format
      options = {
        locale: I18n.locale.to_s,
        date:   Time.now.utc.to_date.to_s,
        format: "#{format}_#{format.mobile? ? :mobile : :html}"
      }
      controller.params.merge options
    end

    def my_caches_action(action)
      options = {
        layout:     false,
        if:         method(:caches_action_condition).to_proc,
        cache_path: method(:caches_action_cache_path).to_proc,
      }
      caches_action action, options
    end
  end
end
