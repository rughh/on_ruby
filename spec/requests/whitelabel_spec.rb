require 'spec_helper'

describe 'Whitelabel' do
  context 'GET label page with non existing subdomain' do
    it 'does not do an endless redirect but halts' do
      host! 'www.onruby.test'
      get labels_path
      expect(response).to be_a_successful
    end
  end

  context 'GET page with non existing subdomain' do
    it 'redirects to main url' do
      get root_url(subdomain: 'rostock')
      expect(response).to redirect_to(labels_url(subdomain: 'www'))
    end
  end

  context 'GET page with existing subdomain' do
    it 'shows the label' do
      get root_url(subdomain: 'hamburg')
      expect(response).to be_a_successful
    end
  end

  context 'GET page with custom domain' do
    it 'shows the label' do
      host! 'www.colognerb.de'

      get root_url
      expect(response).to be_a_successful
      expect(Whitelabel[:label_id]).to eql('cologne')
    end
  end
end
