module Bitly
  def self.new
    Bitly::V3::Client.new(ENV['BITLY_LOGIN'], ENV['BITLY_API_KEY'])
  end
end
