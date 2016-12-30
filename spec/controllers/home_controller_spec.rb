require 'spec_helper'

describe HomeController do
  context 'subdomains' do
    before { set_subdomain }

    context 'GET :index' do
      it 'should render the :index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  context 'main domain' do
    before { set_subdomain('www') }

    context 'GET :index' do
      it 'should render the :index template' do
        get :index
        expect(response).to redirect_to('http://www.onruby.dev/')
      end
    end
  end

  context 'custom domains' do
    before { set_custom_domain }

    context 'GET :index' do
      it 'should render the :index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
end
