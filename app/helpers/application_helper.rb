module ApplicationHelper
  def repos(nickname)
    logger.info "getting repos for #{nickname}"
    resp = Faraday.get "http://github.com/api/v2/json/repos/show/#{nickname}"
    repos = Hashie::Mash.new(JSON.parse(resp.body)).repositories || []
    repos.sort{|a, b| b.watchers + b.forks <=> a.watchers + a.forks}[0..2]
  rescue
    logger.warn $!
    []
  end
end
