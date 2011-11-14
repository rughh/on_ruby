require 'spec_helper'

describe UsersController do

  let(:user) { Factory(:user) }
  let(:data) { {id: user.id, user: { github: 'testo', freelancer: true, available: true }} }
  let(:unallowed_data) { data.merge({:user => {:nickname => 'not_allowed_property'}}) }

  describe "GET :index" do

    before do
      Factory(:user)
      request.env['x-api-key'] = ''
    end

    it "should redirect and have status not_authorized" do
      get :index, format: :json
      response.status.should eql(401)
      response.body.should eql(' ')
    end

    it "should render json with valid api-key" do
      request.env['x-api-key'] = ENV["HOR_API_KEY"] = 'bla'
      get :index, format: :json
      response.status.should eql(200)
      JSON.parse(response.body)["users"].should have(1).elements
    end
  end

  describe "GET :edit" do
    it "should show alert for wrong user" do
      get :edit, id: user.id
      flash[:alert].should_not be_nil
      response.should redirect_to(root_url)
    end
  end

  describe "PUT :update" do
    before do
      request.env["HTTP_REFERER"] = root_url
    end

    it "should update the github attribute of a user" do
      @controller.stubs(current_user: user)
      put :update, data
      controller.user.tap do |user|
        user.github.should eql('testo')
        user.freelancer.should be_true
        user.available.should be_true
      end
      response.should redirect_to(:back)
    end

    it "should not update injected properties" do
      @controller.stubs(current_user: user)
      put :update, data
      controller.user.nickname.should eql(user.nickname)
    end

    it "should update nothing for wrong user" do
      put :update, data
      flash[:alert].should_not be_nil
      response.should redirect_to(root_url)
    end
  end

end
