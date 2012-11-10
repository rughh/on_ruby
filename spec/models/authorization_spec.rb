require 'spec_helper'

describe Authorization do
  it "should create an auth and a user from an auth-hash" do
    expect do
      expect do
        Authorization.handle_authorization(TWITTER_AUTH_HASH)
      end.to change(User, :count).by(1)
    end.to change(Authorization, :count).by(1)
  end
end
