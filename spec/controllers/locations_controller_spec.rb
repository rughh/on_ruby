require 'spec_helper'

describe LocationsController do
  context 'GET :index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  context 'GET :show' do
    let(:location) { create(:location) }

    it 'renders the :show template' do
      get :show, params: { id: location }

      expect(controller.location).to eql(location)
      expect(response).to render_template(:show)
    end
  end
end
