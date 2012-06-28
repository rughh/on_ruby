require 'spec_helper'

describe Usergroup do
  let(:rughh) { Whitelabel.label_for("hamburg") }
  let(:colognerb) { Whitelabel.label_for("cologne") }
  let(:hackhb) { Whitelabel.label_for("bremen") }
  
  let(:some_date) { Time.new(2011, 9, 1, 0, 0, 0) }
  let(:first_wednesday) { Time.new(2011, 9, 7, 0, 0, 0) }
  let(:second_wednesday) { Time.new(2011, 9, 14, 0, 0, 0) }
  let(:third_wednesday) { Time.new(2011, 9, 21, 0, 0, 0) }

  describe "#next_event_date" do
    it "should always be in the future on wednesday" do
      [rughh, hackhb, colognerb].each do |usergroup|
        usergroup.next_event_date.should be_wednesday
        usergroup.next_event_date.should be > Date.today
      end
    end

    it "should find the right wednesday" do
      hackhb.parse_recurring(some_date).should eql(first_wednesday)
      rughh.parse_recurring(some_date).should eql(second_wednesday)
      colognerb.parse_recurring(some_date).should eql(third_wednesday)
    end
  end
end
