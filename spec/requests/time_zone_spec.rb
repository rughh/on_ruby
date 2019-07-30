# typed: false
require 'spec_helper'

describe 'TimeZone' do
  context 'GET page without a time zone' do
    it 'should have the default time zone' do
      get root_url(subdomain: 'hamburg')
      expect(Time.zone.name).to eq('Europe/Berlin')
    end
  end

  context 'GET page with a different default time zone' do
    before { allow(Whitelabel.labels.first).to receive_messages(default_time_zone: 'Europe/Paris') }

    it 'should have a different time zone' do
      get root_url(subdomain: 'hamburg')
      expect(Time.zone.name).to eq('Europe/Paris')
    end
  end

  context 'GET page with a time zone param' do
    it 'sets the requested time zone over default time zone' do
      get root_url(subdomain: 'hamburg', time_zone: 'Europe/Paris')
      expect(Time.zone.name).to eq('Europe/Paris')
    end

    it 'falls back to defaults' do
      get root_url(subdomain: 'hamburg', time_zone: 'Europe/Paris')
      expect(Time.zone.name).to eq('Europe/Paris')
      get root_url(subdomain: 'hamburg', time_zone: '')
      expect(Time.zone.name).to eq('Europe/Berlin')
      get root_url(subdomain: 'hamburg', time_zone: 'Inexisting/Timezone')
      expect(Time.zone.name).to eq('Europe/Berlin')
    end
  end
end
