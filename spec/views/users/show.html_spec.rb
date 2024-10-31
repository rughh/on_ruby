require 'spec_helper'

describe 'users/show' do
  let(:user) { build(:user, id: 123) }
  let(:dom) { Nokogiri::HTML(rendered) }

  before { allow(view).to receive_messages(current_user: user, user:) }

  it 'renders successfully' do
    render

    expect(dom.at_css('.card .card-body .card-title').inner_text).to include(user.nickname)
  end

  context 'when user was just created through email OTP' do
    let(:user) { User.create_from_hash!(EMAIL_AUTH_HASH) }

    it 'hides nickname' do
      render

      expect(dom.at_css('.card .card-body .card-title').inner_text).not_to include(user.nickname)
    end

    it 'shows name placeholder', :aggregate_failures do
      render

      expect(dom.at_css('.card .card-body .card-title').inner_text).not_to include(user.name)
      expect(dom.at_css('.card .card-body .card-title').inner_text).to include('-')
    end
  end
end
