require 'spec_helper'

describe Like do

  let(:like) { create(:like) }

  context "validation" do
    it "should be valid" do
      like.should be_valid
    end

    it "should validate presence" do
      Like.new.tap do |it|
        it.should have(1).errors_on(:user)
        it.should have(1).errors_on(:topic)
      end
    end
  end
end
