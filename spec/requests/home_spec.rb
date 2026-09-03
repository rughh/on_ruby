require 'spec_helper'

describe 'Home', type: :request do
  it 'renders the landing page on a usergroup subdomain' do
    get root_url(subdomain: 'hamburg')

    expect(response).to be_ok
  end

  it 'renders the landing page on a custom domain' do
    host! 'www.rug-b.de'

    get root_url

    expect(response).to be_ok
  end
end
