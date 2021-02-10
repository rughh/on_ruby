# frozen_string_literal: true

module LinkHelper
  def link_to_user(user, image: false, image_class: nil)
    link_to(user, title: user.name) do
      image ? user_image(user, image_class: image_class) + user.name : user.name
    end
  end

  def user_image(user, image_class: nil)
    image_class ||= 'small-user-image'
    image_tag(cache_image_path(user), title: user.name, class: image_class)
  end

  def link_to_job(job)
    link_to job.name, job.url, title: job.name
  end

  def link_to_event(event)
    fa_icon('calendar-o', text: link_to(event.name, event, title: event.name, class: 'with-icon'))
  end

  def link_to_topic(topic)
    fa_icon('comment-o', text: link_to(topic.name, topic, title: topic.name, class: 'with-icon'))
  end

  def link_to_material(material)
    fa_icon('list-ul', text: link_to(material.name, material.url, title: material.name, target: '_blank', class: 'with-icon', rel: 'noopener'))
  end

  def link_to_mailing_list(entry)
    fa_icon('envelope-o', text: link_to(entry.title, entry.url, title: entry.title, class: 'with-icon'))
  end

  def job_description(job)
    t('hint.job_description', city: I18n.tw('city'), job_link: tag.strong(link_to(job.name, job.url, title: job.name, target: '_blank', rel: 'noopener')), company_link: link_to_location(job.location))
  end

  def link_to_location(location)
    "#{link_to(location.name, location, title: location.name)} #{fa_icon('external-link', text: link_to(location.nice_url, location.url, title: location.name, target: '_blank', rel: 'noopener'))}".html_safe
  end

  def link_to_route(location)
    return link_to(t('home.no_location'), none_locations_path) if location.blank?

    tag.span(link_to(location.address, '#route', title: "#{location.name}, #{location.address}")) +
      " #{t('show.at')} " +
      tag.span(link_to_location(location), class: 'open-icon')
  end

  def link_to_external_route(location)
    text = "#{t('location.open_in')} #{t('location.google_maps')}"
    link_to(text, "https://maps.google.com/?q=#{location.address}", target: '_blank', rel: 'noopener')
  end
end
