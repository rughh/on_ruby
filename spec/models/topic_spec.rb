require 'spec_helper'

describe Topic do

  let(:topic) { create(:topic) }

  context "validation" do
    it "should be valid" do
      topic.should be_valid
    end

    it "should validate presence" do
      Topic.new.tap do |it|
        it.should have(1).errors_on(:name)
        it.should have(1).errors_on(:description)
      end
    end

    it "should validate uniqueness" do
      build(:topic, name: topic.name).should have(1).errors_on(:name)
    end
  end

  context "likes" do
    let(:like) { build(:like, :topic => nil) }

    it "indicates already_liked?" do
      topic.likes << like
      topic.already_liked?(like.user).should be_true
    end
  end
end
