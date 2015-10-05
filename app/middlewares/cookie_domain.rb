# http://codetunes.com/2009/04/17/dynamic-cookie-domains-with-racks-middleware
class CookieDomain
  def initialize(app, default_domain)
    @app = app
    @default_domain = default_domain
  end

  def call(env)
    host = env["HTTP_HOST"].split(':').first
    env["rack.session.options"][:domain] = custom_domain?(host) ? ".#{host}" : "#{@default_domain}"
    @app.call(env)
  end

  def custom_domain?(host)
    domain = @default_domain.sub(/^\./, '')
    host !~ Regexp.new("#{domain}$", Regexp::IGNORECASE)
  end
end
