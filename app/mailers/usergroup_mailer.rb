# typed: false
class UsergroupMailer < ActionMailer::Base
  def invitation_mail(event)
    @event = event
    options = {
      from: %Q("#{I18n.tw('name')}" <onruby@googlemail.com>),
      to: "rubyonrails-ug-germany@googlegroups.com",
      subject: "#{Whitelabel[:label_id].upcase} Info: #{event.name}",
    }
    default_url_options[:host] = Whitelabel[:canonical_url]
    mail(options)
  end
end
