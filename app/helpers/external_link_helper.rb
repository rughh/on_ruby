# encoding: UTF-8
module ExternalLinkHelper
  def link_to_twitter(thing, params={clung: false}, &block)
    nick = thing.respond_to?(:nickname) ? thing.nickname : thing
    url = "http://twitter.com/#{nick}"
    if block_given?
      link_to url, title: nick, &block
    else
      link = "@#{link_to(nick, url, title: nick)}"
      raw params[:clung] ? "(#{link})" : link
    end
  end

  def link_to_github(user, &block)
    return unless user.github
    url = "http://github.com/#{user.github}"
    title = user.github
    if block_given?
      link_to url, title: title, &block
    else
      link_to(user.github, url, title: title)
    end
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

  def ribbon(type)
    types = {
      github:          ["Fork me on GitHub!", "https://github.com/phoet/on_ruby"],
      senor_developer: ["Señor Developer!",   "http://senordevelopershop.spreadshirt.de"],
    }
    text, url = types[type]
    content_tag :div, id: "#{type}_ribbon", class: 'ribbon_wrap' do
      link_to url, id: type, title: text do
        content_tag :span, text
      end
    end
  end
end
