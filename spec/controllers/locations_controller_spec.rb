require 'spec_helper'

describe LocationsController do
  context 'GET :index' do
    it 'should render the :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
