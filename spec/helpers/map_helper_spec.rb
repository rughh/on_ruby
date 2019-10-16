require 'spec_helper'

describe MapHelper do
  context '#link_to_github' do
    it 'should generate the link' do
      location = build(:location, lat: 12, long: 11)
      expect(helper.static_map(location)).to eql('http://maps.googleapis.com/maps/api/staticmap?zoom=12&sensor=false&key=AIzaSyBskJCTxAU9UbH3qijy46oNtZ1-4ad14PM&markers=12.0,11.0')
    end
  end
end
