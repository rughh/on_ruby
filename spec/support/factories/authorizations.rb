# encoding: UTF-8

AUTH_HASH = {
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

FactoryGirl.define do
  factory :authorization do
    provider "provider"
    uid "uid"
    association :user, :factory => :user
  end
end
