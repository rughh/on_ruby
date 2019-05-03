module CacheExpiration
  extend ActiveSupport::Concern

  included { after_commit :expire_view_cache }

  def expire_view_cache
    I18n.available_locales.each do |locale|
      [%i[home index], %i[highlights], %i[jobs]].each do |segment|
        key = [:views, Whitelabel[:label_id], locale]
        key = key.concat(segment).join('/')
        Rails.logger.info "expire fragment '#{key}'"
        Rails.cache.delete key
      end
    end
  end
end
