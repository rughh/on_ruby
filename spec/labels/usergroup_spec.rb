require 'spec_helper'

describe Usergroup do
  let(:rughh) { Whitelabel.label_for("hamburg") }
  let(:colognerb) { Whitelabel.label_for("cologne") }
  let(:hackhb) { Whitelabel.label_for("bremen") }

  it "should be a Rughh" do
    rughh.should be_an_instance_of(Rughh)
    colognerb.should be_an_instance_of(Colognerb)
    hackhb.should be_an_instance_of(Hackhb)
  end

  describe "#next_event_date" do
    it "should always be in the future on wednesday" do
      [rughh, hackhb, colognerb].each do |usergroup|
        usergroup.next_event_date.should be_wednesday
        usergroup.next_event_date.should be > Date.today
      end
    end

    it "should find the right wednesday" do
      hackhb.first_wednesday(Time.new(2011, 9, 1, 0, 0, 0)).should eql(Time.new(2011, 9, 7, 0, 0, 0))
      rughh.second_wednesday(Time.new(2011, 9, 1, 0, 0, 0)).should eql(Time.new(2011, 9, 14, 0, 0, 0))
      colognerb.third_wednesday(Time.new(2011, 9, 1, 0, 0, 0)).should eql(Time.new(2011, 9, 21, 0, 0, 0))
    end
  end
end
