require "spec_helper"

describe UsergroupMailer do

  let(:event) { create(:event) }

  context "sending a mail" do
    it "should send the mail" do
      email = UsergroupMailer.invitation_mail(event).deliver
      ActionMailer::Base.deliveries.should_not be_empty

      email.to.should eql(["rubyonrails-ug-germany@googlegroups.com"])
      email.subject.should match(event.name)
      email.encoded.should =~ /<h1>#{event.name}<\/h1>/
    end
  end
end
