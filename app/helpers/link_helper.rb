module LinkHelper
  def link_to_user(user)
    link_to user.name, user, title: user.name
  end

  def link_to_job(job)
    link_to job.name, job.url, title: job.name
  end

  def link_to_event(event)
    link_to event.name, event, title: event.name
  end

  def link_to_topic(topic)
    link_to topic.name, topic, title: topic.name
  end

  def job_description(job)
    t("hint.job_description", city: I18n.tw("city"), job_link: content_tag(:strong, link_to(job.name, job.url, title: job.name)), company_link: link_to_location(job.location))
  end

  def link_to_location(location)
    "#{link_to location.name, location, title: location.name} (#{link_to location.nice_url, location.url, title: location.name})".html_safe
  end

  def link_to_route(location)
    content_tag :p, class: :meta do
      content_tag(:span, link_to(location.address, "#route", title: "#{location.name}, #{location.address}"), class: 'map-icon') +
      " #{t("show.at")} " +
      content_tag(:span, link_to_location(location), class: 'open-icon')
    end
  end

  def link_to_external_route(location)
    content_tag :p, class: "external-maps" do
      html = "".html_safe
      html << "#{t("location.open_in")}: "
      html << link_to(t("location.google_maps"), "https://maps.google.com/?q=#{location.address}", target: "_blank")
    end
  end
end
