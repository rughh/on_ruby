class IndexSweeper < ActionController::Caching::Sweeper
  observe Event, Highlight, Job, Location, Participant, User, Vote, Wish

  def after_create(entitiy)
    expire_index_cache
  end

  def after_update(entitiy)
    expire_index_cache
  end

  def after_destroy(entitiy)
    expire_index_cache
  end

  private

  def expire_index_cache
    if Rails.env.test?
      Rails.logger.info "not invalidating the cache for tests"
    else
      Rails.logger.info "invalidating the whole cache"
      Rails.cache.clear
    end
  end
end
