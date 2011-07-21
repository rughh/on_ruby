class UsergroupMailer < ActionMailer::Base
  default :from => AppConfig.email
  default_url_options[:host] = AppConfig.host
  
  def invitation_mail(event)
    @event = event
    recipient = AppConfig.usergroup_email
    mail(:to => recipient, :subject => "RUGHH Info: #{event.name}")
  end
end
