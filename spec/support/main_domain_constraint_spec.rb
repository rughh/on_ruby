require 'spec_helper'

describe MainDomainConstraint do
  it "matches the right domain" do
    ["www.onruby.de", "www.onruby.dev", "www.onruby.org", "www.onruby.co"].each do |host|
      request = OpenStruct.new(host: host)
      subject.matches?(request).should be_true
    end
    ["onruby.de", "www.rug-b.de"].each do |host|
      request = OpenStruct.new(host: host)
      subject.matches?(request).should be_false
    end
  end
end
