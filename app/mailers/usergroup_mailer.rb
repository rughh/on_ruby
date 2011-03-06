class UsergroupMailer < ActionMailer::Base
  default :from => AppConfig.email
  
  def invitation_mail(event)
    @event = event
    mail(:to => AppConfig.usergroup_email, :subject => event.name)
  end
end
