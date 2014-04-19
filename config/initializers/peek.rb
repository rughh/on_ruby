Peek.into Peek::Views::Git, :nwo => 'phoet/on_ruby'
Peek.into Peek::Views::PerformanceBar
Peek.into Peek::Views::Dalli
Peek.into Peek::Views::PG
Peek.into Peek::Views::GC

OnRuby::Application.configure do
  config.peek.adapter = :memcache
end
