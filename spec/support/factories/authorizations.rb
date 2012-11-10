# encoding: UTF-8

TWITTER_AUTH_HASH = {
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

GITHUB_AUTH_HASH = {
  "provider"=>"github",
  "uid"=>"48745",
  "info"=>{
    "nickname"=>"phoet",
    "email"=>"phoetmail@googlemail.com",
    "name"=>"Peter Schröder",
    "image"=>
    "https://secure.gravatar.com/avatar/056c32203f8017f075ac060069823b66?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
    "urls"=>{
      "GitHub"=>"https://github.com/phoet", "Blog"=>"http://blog.nofail.de"
    }
  },
  "credentials"=>{
    "token"=>"b87a73dfb7aaca39b138abae74d0439fc5677a4f", "expires"=>false
  },
  "extra"=>{
    "raw_info"=>{
      "html_url"=>"https://github.com/phoet",
      "type"=>"User",
      "company"=>"Señor Developer ☠ nofail ",
      "followers"=>30,
      "created_at"=>"2009-01-23T13:07:36Z",
      "avatar_url"=>
      "https://secure.gravatar.com/avatar/056c32203f8017f075ac060069823b66?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
      "public_repos"=>63,
      "blog"=>"http://blog.nofail.de",
      "hireable"=>true,
      "following"=>0,
      "email"=>"phoetmail@googlemail.com",
      "bio"=>
      "My name is Peter Schr&ouml;der aka _phoet_ living in Hamburg - Germany.\r\n\r\nI am a freelance developer, working with web applications for nearly a decade.\r\n\r\nRuby and Ruby on Rails are currently my most favorite toolbox items. I like playing around with this amazing and beatiful language, evaluating well designed libraries and easy to use frameworks.\r\n\r\nCheck out my \r\n\r\n* [technical blog](http://blog.nofail.de)\r\n* [WorkingWithRails profile](http://www.workingwithrails.com/person/17645-peter-schr-der/)\r\n* [my timeline at twitter](http://twitter.com/phoet/)\r\n* [my facebook](http://www.facebook.com/peter.schroeder.uschi/)\r\n* [personal website](http://www.phoet.de/)\r\n* [professional resume at xing](https://www.xing.com/profile/peter_schroeder2/)\r\n* [or at LinkedIn](http://www.linkedin.com/in/phoet/)\r\n",
      "location"=>"Hamburg, Germany",
      "name"=>"Peter Schröder",
      "url"=>"https://api.github.com/users/phoet",
      "gravatar_id"=>"056c32203f8017f075ac060069823b66",
      "id"=>48745,
      "public_gists"=>29,
      "login"=>"phoet"
    }
  }
}

FactoryGirl.define do
  factory :authorization do
    provider "provider"
    uid "uid"
    association :user, :factory => :user
  end
end
