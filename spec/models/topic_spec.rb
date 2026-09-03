require 'spec_helper'

describe Topic do
  let(:topic) { create(:topic) }

  context 'validation' do
    it 'is valid' do
      expect(topic).to be_valid
    end

    it 'validates presence' do
      Topic.new.tap do |it|
        expect(errors_on(it, :name).size).to eq(1)
        expect(errors_on(it, :description).size).to eq(1)
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

  context 'scopes' do
    let!(:past_topic)   { create(:topic, event: create(:event, date: 1.day.ago)) }
    let!(:future_topic) { create(:topic, event: create(:event, date: 1.day.from_now)) }

    # NOTE: `done` / `upcoming` split on `Time.now - 2.hours` (see Topic model),
    # so an event is still "upcoming" until two hours after it started.
    it '.done returns topics whose event is more than two hours in the past' do
      expect(Topic.done).to contain_exactly(past_topic)
    end

    it '.upcoming returns topics whose event has not started (or started < 2h ago)' do
      expect(Topic.upcoming).to contain_exactly(future_topic)
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
