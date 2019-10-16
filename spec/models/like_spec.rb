require 'spec_helper'

describe Like do
  let(:like) { create(:like) }

  context 'validation' do
    it 'should be valid' do
      expect(like).to be_valid
    end

    it 'should validate presence' do
      Like.new.tap do |it|
        expect(it).to have(2).errors_on(:user)
        expect(it).to have(2).errors_on(:topic)
      end
    end
  end
end
