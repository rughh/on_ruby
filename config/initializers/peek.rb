Peek.into Peek::Views::Git, :nwo => 'phoet/on_ruby'
Peek.into Peek::Views::PerformanceBar
Peek.into Peek::Views::PG
Peek.into Peek::Views::GC

if defined? Dalli
  Peek.into Peek::Views::Dalli
  OnRuby::Application.configure do
    config.peek.adapter = :memcache, {
      client: Dalli::Client.new(ENV["MEMCACHIER_SERVERS"], username: ENV["MEMCACHIER_USERNAME"], password: ENV["MEMCACHIER_PASSWORD"]),
      expires_in: 60 * 30
    }
  end
end