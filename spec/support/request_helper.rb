module RequestHelper
  def set_referer(referer = root_url)
    @request.env["HTTP_REFERER"] = referer
  end

  def set_subdomain(subdomain = "hamburg")
    @request.host = "#{subdomain}.onruby.dev"
  end

  def set_custom_domain(domain = "www.rug-b.de")
    @request.host = domain
  end

  def stub_feedzirra
    result = OpenStruct.new(entries: [])
    Feedzirra::Feed.stub(fetch_and_parse: result)
  end
end
