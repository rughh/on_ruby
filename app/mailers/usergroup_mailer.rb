class UsergroupMailer < ActionMailer::Base
  def invitation_mail(event)
    @event = event
    options = {
      to: Whitelabel[:usergroup_email],
      subject: "#{Whitelabel[:label_id].upcase} Info: #{event.name}",
      from: Whitelabel[:email]
    }
    default_url_options[:host] = Whitelabel[:host]
    mail(options)
  end
end
