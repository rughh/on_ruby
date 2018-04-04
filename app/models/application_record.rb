class ApplicationRecord < ActiveRecord::Base
  include CacheExpiration

  self.abstract_class = true
end
