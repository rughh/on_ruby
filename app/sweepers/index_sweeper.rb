class IndexSweeper < ActionController::Caching::Sweeper
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
    [:de, :en].each do |locale|
      key = [:views, Whitelabel[:label_id], locale, :home, :index]
      key = key.join("/")
      Rails.logger.info "expire fragment '#{key}'"
      Rails.cache.delete key
    end
  end
end
