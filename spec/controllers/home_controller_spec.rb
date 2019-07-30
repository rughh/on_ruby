# typed: false
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
