module RequestHelper
  def set_referer(referer = root_url)
    @request.env['HTTP_REFERER'] = referer
  end

  def set_subdomain(subdomain = 'hamburg')
    @request.host = "#{subdomain}.onruby.dev"
  end

  def set_custom_domain(domain = 'www.rug-b.de')
    @request.host = domain
  end
end
