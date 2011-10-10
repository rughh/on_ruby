require 'spec_helper'

describe Topic do

  let(:topic) { Factory(:topic) }

  context "validation" do
    it "should be valid" do
      topic.should be_valid
    end

    it "should validate presence" do
      Topic.new.tap do |it|
        it.should have(1).errors_on(:event)
        it.should have(1).errors_on(:name)
        it.should have(1).errors_on(:description)
      end
    end

    it "should validate uniqueness" do
      Factory.build(:topic, name: topic.name).should have(1).errors_on(:name)
    end
  end
end
