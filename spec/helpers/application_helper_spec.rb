require 'spec_helper'

describe ApplicationHelper do
  context 'markdown' do
    it 'underlines' do
      expect(helper.markdown('*underline*')).to match('<em>underline</em>')
    end

    it 'autolinks' do
      expect(helper.markdown('auto http://href.org')).to match('auto <a href="http://href.org">http://href.org</a>')
    end

    it 'escapes html tags' do
      expect(helper.markdown('<script>alert("xss");</script>'))
        .to include('&lt;script&gt;alert(&quot;xss&quot;);&lt;/script&gt;')
    end
  end

  describe '#browser_icon' do
    it 'falls back to the default favicon when the whitelabel icon is missing' do
      allow(Whitelabel).to receive(:label).and_return(instance_double(Whitelabel))
      allow(Whitelabel).to receive(:[]).with(:label_id).and_return('tokio')

      expect(helper.browser_icon).to include('href="/assets/favicon')
    end

    it 'uses the whitelabel favicon when it exists' do
      allow(Whitelabel).to receive(:label).and_return(instance_double(Whitelabel))
      allow(Whitelabel).to receive(:[]).with(:label_id).and_return('berlin')

      expect(helper.browser_icon).to include('labels/berlin')
    end
  end

  describe '#label_logo_asset' do
    it 'falls back to the default logo when the whitelabel logo is missing' do
      expect(helper.label_logo_asset('tokio')).to eq('logo.png')
    end

    it 'uses the whitelabel logo when it exists' do
      expect(helper.label_logo_asset('berlin')).to eq('labels/berlin.png')
    end
  end
end
