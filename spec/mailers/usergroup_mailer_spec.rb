require "spec_helper"

describe UsergroupMailer do
  before do
    @event = Factory(:event)
  end

  context "sending a mail" do
    it "should send the mail" do
      email = UsergroupMailer.invitation_mail(@event).deliver
      assert !ActionMailer::Base.deliveries.empty?
      
      email.to.should eql([AppConfig.usergroup_email])
      email.subject.should eql(@event.name)
      email.encoded.should =~ /<h1>#{@event.name}<\/h1>/
    end
  end
end
