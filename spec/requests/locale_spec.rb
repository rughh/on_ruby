require 'spec_helper'

describe 'Locale' do
  context 'GET page without a locale' do
    it 'should have the default locale' do
      get root_url(subdomain: 'hamburg')
      expect(I18n.locale).to be(:de)
    end
  end

  context 'GET page with a different default locale' do
    before { allow(Whitelabel.labels.first).to receive_messages(default_locale: :en) }

    it 'should have a different default locale' do
      get root_url(subdomain: 'hamburg')
      expect(I18n.locale).to be(:en)
    end
  end

  context 'GET page with a locale cookie' do
    it 'sets the locale via cookie' do
      get root_url(subdomain: 'hamburg')
      expect(I18n.locale).to be(:de)
      get root_url(subdomain: 'hamburg', locale: :en)
      expect(I18n.locale).to be(:en)
      get root_url(subdomain: 'hamburg')
      expect(I18n.locale).to be(:en)
    end
  end

  context 'GET page with a locale param' do
    it 'sets the requested locale over the cookie and default locale' do
      get root_url(subdomain: 'hamburg', locale: :en)
      expect(I18n.locale).to be(:en)
    end

    it 'falls back to defaults' do
      get root_url(subdomain: 'hamburg', locale: :fr)
      expect(I18n.locale).to be(:de)
      get root_url(subdomain: 'hamburg', locale: '')
      expect(I18n.locale).to be(:de)
      get root_url(subdomain: 'hamburg', locale: '/proc/self/environ\u0000')
      expect(I18n.locale).to be(:de)
    end
  end
end
