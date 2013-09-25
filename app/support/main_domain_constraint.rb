class MainDomainConstraint
  def matches?(request)
    request.host =~ /www\.onruby\.\w+/
  end
end
