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
    Rails.logger.info "invalidating home#index cache"
    expire_action controller: "/home", action: "index"
  end
end
