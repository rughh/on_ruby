class MiscController < ApplicationController
  def sitemap
    @urls = []
    @urls << root_url
    @urls += Wish.all.map {|wish| url_for wish}
    @urls += Event.all.map {|event| url_for event}
    @urls += User.all.map {|user| url_for user}
    
    response.headers["Content-Type"] = 'text/xml'
    render :layout=>false
  end
end
