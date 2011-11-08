# encoding: utf-8
require 'spec_helper'

describe Authorization do

  let(:auth) do
    {
      "provider"=>"twitter",
      "uid"=>"14339524",
      "info"=>{
        "nickname"=>"phoet",
        "name"=>"Peter Schröder",
        "location"=>"Sternschanze, Hamburg",
        "image"=>"http://a3.twimg.com/profile_images/1100439667/P1040913_normal.JPG",
        "description"=>"I am a freelance Ruby and Java developer from Hamburg, Germany. ☠ nofail",
        "urls"=>{"Website"=>"http://nofail.de"}
      }
    }
  end

  it "should create an auth and a user from an auth-hash" do
    expect do
      Authorization.create_from_hash(auth)
    end.to change(Authorization, :count).by(1)
  end
end
