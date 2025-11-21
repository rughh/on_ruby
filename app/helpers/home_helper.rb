# frozen_string_literal: true

module HomeHelper
  def next_event_date
    l(Whitelabel[:next_event_date], format: :long)
  end

  def localized_recurring_event_date
    Whitelabel[:localized_recurring]
  end

  def contact_text
    capture do
      concat t('home.send_us_an_email', mail_to: mail_to(Whitelabel[:email], 'E-Mail', title: 'E-Mail')).html_safe
      concat " #{t('home.or_message_on_twitter', twitter_link: link_to_twitter(Whitelabel[:twitter]))}".html_safe if Whitelabel[:twitter]
      concat '.'
    end
  end

  def header_image_path
    File.join('labels', Whitelabel[:label_id], 'header.png')
  end

  def header_image_available?
    Rails.root.join('app', 'assets', 'images', header_image_path).exist?
  end
end
