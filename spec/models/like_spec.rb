require 'spec_helper'

describe Like do
  let(:like) { create(:like) }

  context 'validation' do
    it 'is valid' do
      expect(like).to be_valid
    end

    it 'validates presence' do
      Like.new.tap do |it|
        expect(errors_on(it, :user).size).to eq(2)
        expect(errors_on(it, :topic).size).to eq(2)
      end
    end
  end
end
