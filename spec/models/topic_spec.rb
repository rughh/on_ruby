require 'spec_helper'

describe Topic do
  let(:topic) { create(:topic) }

  context 'validation' do
    it 'is valid' do
      expect(topic).to be_valid
    end

    it 'validates presence' do
      Topic.new.tap do |it|
        expect(it).to have(1).errors_on(:name)
        expect(it).to have(1).errors_on(:description)
      end
    end
  end

  context 'likes' do
    let(:like) { build(:like, topic: nil) }

    it 'indicates already_liked?' do
      topic.likes << like
      expect(topic.already_liked?(like.user)).to be_truthy
    end
  end

  context 'name' do
    it 'allows two topics with the same name' do
      expect(build(:topic, name: topic.name)).to be_valid
    end

    it 'gives unique slugs to two topics with the same name' do
      second_topic = create(:topic, name: topic.name)
      expect(topic.to_param).not_to eq(second_topic.to_param)
    end
  end
end
