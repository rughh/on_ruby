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

  def flash_growl
    if notice
      javascript_tag "humane('#{flash[:notice]}');"
    elsif alert
      javascript_tag "humane(\"<p class='error'>#{flash[:alert]}</p>\");"
    end
  end

  def link_to_github(user)
    link_to user.github, "http://github.com/#{user.github}" if user.github
  end

  def link_to_twitter(user, params={:clung => false}, &block)
    url = "http://twitter.com/#{user.nickname}"
    if block_given?
      link_to url, &block
    else
      link = link_to("@#{user.nickname}", url)
      params[:clung] ? ('(' + link + ')').html_safe : link
    end
  end

  def tooltip_box(uid, options={})
    content_tag :div, class: "toggle_#{uid} tooltip #{options[:class]}" do
      concat link_to('[x]', '#', class: 'topbutton toggle', name: uid)
      yield
    end
  end

  def section_box(name, options={})
    content_tag :section, class: name, id: name do
      concat content_tag(:div, options[:topbutton], class: 'topbutton') if options[:topbutton]
      concat content_tag(:h2, t(name))
      yield
    end
  end

end
