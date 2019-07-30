# typed: false
require 'spec_helper'

describe 'locations/none' do
  let(:organizers) { [build(:user, id: 123)] }
  let(:stats) { { participants: 10, topics: 2 } }
  it 'should render successfully' do
    %w(en de).each do |locale|
      I18n.with_locale(locale) do
        allow(view).to receive_messages(organizers: organizers, stats: stats)
        render
      end
    end
  end
end
