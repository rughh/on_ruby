require 'spec_helper'

describe 'Locale' do
  context 'GET page without a locale' do
    it 'has the default locale' do
      get root_url(subdomain: 'hamburg')
      expect(I18n.locale).to be(:de)
    end
  end

  context 'GET page with a different default locale' do
    before { allow(Whitelabel.labels.first).to receive_messages(default_locale: :en) }

    it 'has a different default locale' do
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

  context 'GET page storing the chosen locale' do
    it 'remembers the requested locale in a cookie' do
      get root_url(subdomain: 'hamburg', locale: :de)
      expect(cookies[:locale]).to eq('de')
    end
  end

  context 'GET page with an Accept-Language header' do
    it 'uses the first available locale from the list' do
      get root_url(subdomain: 'hamburg'), headers: { 'Accept-Language' => 'pl-PL, pl;q=0.9, en;q=0.8, *;q=0.5' }
      expect(I18n.locale).to be(:pl)
    end

    it 'falls back to the default locale when none of them are available' do
      get root_url(subdomain: 'hamburg'), headers: { 'Accept-Language' => 'fr-CH, fr;q=0.9, *;q=0.5' }
      expect(I18n.locale).to be(:de)
    end
  end

  context 'GET page with a stored locale cookie' do
    it 'uses the locale from the cookie' do
      cookies[:locale] = 'pl'
      get root_url(subdomain: 'hamburg')
      expect(I18n.locale).to be(:pl)
    end
  end
end
