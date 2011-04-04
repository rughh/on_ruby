class UsergroupMailer < ActionMailer::Base
  default :from => AppConfig.email
  default_url_options[:host] = AppConfig.host
  
  def invitation_mail(event)
    @event = event
    recipient = Rails.env.production? ? AppConfig.usergroup_email_real : AppConfig.usergroup_email
    mail(:to => recipient, :subject => "RUGHH Info: #{event.name}")
  end
end
