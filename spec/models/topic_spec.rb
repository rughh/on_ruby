require 'spec_helper'

describe Topic do
  let(:topic) { create(:topic) }

  context "validation" do
    it "should be valid" do
      expect(topic).to be_valid
    end

    it "should validate presence" do
      Topic.new.tap do |it|
        expect(it).to have(1).errors_on(:name)
        expect(it).to have(1).errors_on(:description)
      end
    end

    it "should validate uniqueness" do
      expect(build(:topic, name: topic.name)).to have(1).errors_on(:name)
    end
  end

  context "likes" do
    let(:like) { build(:like, :topic => nil) }

    it "indicates already_liked?" do
      topic.likes << like
      expect(topic.already_liked?(like.user)).to be_truthy
    end
  end
end
