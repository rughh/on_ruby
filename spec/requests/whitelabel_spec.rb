require 'spec_helper'

describe 'Whitelabel' do
  let(:hamburg) { Usergroup.from_name("hamburg") }
  let(:berlin) { Usergroup.from_name("berlin") }
  let(:tokio) { Usergroup.from_name("tokio") }

  around do |example|
    whitelabel_backup = Whitelabel.labels
    Whitelabel.labels = [
      hamburg,
      berlin,
      tokio
    ]
    example.run
  ensure
    Whitelabel.labels = whitelabel_backup
  end


  context 'GET label page with non existing subdomain' do
    it 'does not do an endless redirect but halts' do
      host! 'www.onruby.test'
      get labels_path
      expect(response).to be_a_successful
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
      host! 'www.tokio.de'

      get root_url
      expect(response).to be_a_successful
      expect(Whitelabel[:label_id]).to eql(tokio.label_id)
    end
  end
end
