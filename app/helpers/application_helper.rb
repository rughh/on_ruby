module ApplicationHelper
  def repos(nickname)
    logger.info "getting repos for #{nickname}"
    resp = HTTParty.get("http://github.com/api/v2/json/repos/show/#{nickname}", :type => :json)
    repos = Hashie::Mash.new(resp).repositories || []
    repos.sort{|a, b| b.watchers + b.forks <=> a.watchers + a.forks}[0..2]
  rescue
    logger.warn $!
    []
  end
end
