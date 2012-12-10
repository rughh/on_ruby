class IndexSweeper < ActionController::Caching::Sweeper
  observe Event, Highlight, Job, Location, Material, Participant, Topic, User, Vote, Wish

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
    cached_actions = [
      [:home, :index]
    ]
    cached_actions.each do |action|
      key = [:views, Whitelabel[:label_id]] + action
      key = key.join("/")
      Rails.logger.info "expire fragment '#{key}'"
      Rails.cache.delete key
    end
  end
end
