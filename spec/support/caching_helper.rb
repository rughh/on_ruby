module CachingHelper
  def with_caching(on = true)
    caching = ActionController::Base.perform_caching
    ActionController::Base.perform_caching = on
    yield
  ensure
    ActionController::Base.perform_caching = caching
  end

  def without_caching(&block)
    with_caching(false, &block)
  end
end