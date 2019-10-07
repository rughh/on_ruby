# frozen_string_literal: true

require 'spec_helper'

describe MainDomainConstraint do
  it 'matches the right domain' do
    ['www.onruby.de', 'www.onruby.test', 'www.onruby.org', 'www.onruby.co'].each do |host|
      request = OpenStruct.new(host: host)
      expect(subject.matches?(request)).to be_truthy
    end
    ['onruby.de', 'www.rug-b.de'].each do |host|
      request = OpenStruct.new(host: host)
      expect(subject.matches?(request)).to be_falsey
    end
  end
end
