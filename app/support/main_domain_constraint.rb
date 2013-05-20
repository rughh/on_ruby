class MainDomainConstraint
  def matches?(request)
    request.host =~ /www.onruby.de/
  end
end
