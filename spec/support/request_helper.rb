module RequestHelper
  def set_referer(referer = root_url)
    @request.env["HTTP_REFERER"] = referer
  end

  def set_subdomain(subdomain = "hamburg")
    @request.host = "#{subdomain}.example.com"
  end
end
