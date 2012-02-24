module ApplicationHelper

  def title
    'Hamburg on Ruby'
  end

  def subtitle
    'Heimathafen der Hamburger Ruby-Community'
  end

  def map(locations, init={})
    locations = Array(locations)
    init = {:zoom => 14, :lat => 53.56544, :long => 9.95947}.merge(init)
    content_tag(:div, '', :class => 'map_canvas', 'data-map' => locations.to_json, 'data-init' => init.to_json)
  end

  def link_to_github(user)
    link_to user.github, "http://github.com/#{user.github}" if user.github
  end

  def link_to_twitter(thing, params={:clung => false}, &block)
    nick = thing.respond_to?(:nickname) ? thing.nickname : thing
    url = "http://twitter.com/#{nick}"
    if block_given?
      link_to url, &block
    else
      link = link_to("@#{nick}", url)
      params[:clung] ? ('(' + link + ')').html_safe : link
    end
  end

  def section_box(name)
    content_tag :section, class: name, id: name do
      concat content_tag(:h2, t(name))
      yield
    end
  end

  def twitter_update_url(text)
    "http://twitter.com/home?status=#{URI.encode(text)}"
  end

  def likes
    content_tag :span, class: 'likes' do
      raw <<-HERE
      <g:plusone size="medium"></g:plusone>
      <a href="https://twitter.com/share" class="twitter-share-button" data-count="horizontal" data-via="hamburgsync" data-lang="de">Tweet</a>
      HERE
    end
  end

  def fork_me_ribbon
    target = "https://github.com/phoet/hamburg_on_ruby"
    img = "https://a248.e.akamai.net/assets.github.com/img/4c7dc970b89fd04b81c8e221ba88ff99a06c6b61/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f77686974655f6666666666662e706e67"
    link_to target do
      image_tag img, alt: "Fork me on GitHub", style: "position: absolute; top: 0; right: 0; border: 0; margin-top: 40px"
    end
  end

  def hint(close=true)
    content_tag(:section, class: :hint) do
      concat content_tag(:div, link_to('Schliessen', '#'), class: :close) if close
      yield
    end
  end
end
