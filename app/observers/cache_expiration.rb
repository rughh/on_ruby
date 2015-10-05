class CacheExpiration < ActiveRecord::Observer
  observe Event, Highlight, Job, Location, Material, Participant, Topic, User, Like

  def after_create(entitiy)
    self.class.expire_view_cache
  end

  def after_update(entitiy)
    self.class.expire_view_cache
  end

  def after_destroy(entitiy)
    self.class.expire_view_cache
  end

  def self.expire_view_cache
    I18n.available_locales.each do |locale|
      [[:home, :index], [:highlights], [:jobs]].each do |segment|
        key = [:views, Whitelabel[:label_id], locale]
        key = key.concat(segment).join("/")
        Rails.logger.info "expire fragment '#{key}'"
        Rails.cache.delete key
      end
    end
  end
end
