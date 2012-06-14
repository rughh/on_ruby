module ExternalLinkHelper
  def link_to_twitter(thing, params={clung: false}, &block)
    nick = thing.respond_to?(:nickname) ? thing.nickname : thing
    url = "http://twitter.com/#{nick}"
    if block_given?
      link_to url, &block
    else
      link = link_to("@#{nick}", url)
      params[:clung] ? ('(' + link + ')').html_safe : link
    end
  end

  def link_to_github(user)
    link_to user.github, "http://github.com/#{user.github}" if user.github
  end

  def twitter_update_url(model)
    case model
    when Event
      options = {name: model.name, date: l(model.date, locale: :de, format: :short), url: event_url(model)}
    when Wish
      options = {nickname: model.user.nickname, name: model.name.truncate(50), url: wish_url(model)}
    end
    text = t("#{model.class.to_s.downcase}.twitter_message", options)
    "http://twitter.com/home?status=#{URI.encode(text)}"
  end

  def likes
    content_tag :span, class: 'likes' do
      raw %Q(<g:plusone size="medium"></g:plusone><a href="https://twitter.com/share" class="twitter-share-button" data-count="horizontal" data-via="#{Whitelabel[:twitter]}" data-lang="de">Tweet</a>)
    end
  end

  def fork_me_ribbon
    target = "https://github.com/phoet/on_ruby"
    img    = "https://a248.e.akamai.net/camo.github.com/4c7dc970b89fd04b81c8e221ba88ff99a06c6b61/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f77686974655f6666666666662e706e67"
    link_to target do
      image_tag img, alt: "Fork me on GitHub", style: "position: fixed; top: 0; right: 0; border: 0; margin-top: 40px"
    end
  end
end
