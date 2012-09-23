class UsergroupMailer < ActionMailer::Base
  def invitation_mail(event)
    @event = event
    options = {
      from: %Q("#{I18n.tw('name')}" <#{Whitelabel[:email]}>),
      to: "rubyonrails-ug-germany@googlegroups.com",
      subject: "#{Whitelabel[:label_id].upcase} Info: #{event.name}",
    }
    default_url_options[:host] = Whitelabel[:host]
    mail(options)
  end
end
