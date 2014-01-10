require "spec_helper"

describe UsergroupMailer do

  let(:event) { create(:event) }

  context "sending a mail" do
    it "should send the mail" do
      email = UsergroupMailer.invitation_mail(event).deliver
      ActionMailer::Base.deliveries.should_not be_empty

      expect(email.to).to eql(["rubyonrails-ug-germany@googlegroups.com"])
      expect(email.subject).to match(event.name)
      expect(email.encoded).to match(/<h1>#{event.name}<\/h1>/)
    end
  end
end
