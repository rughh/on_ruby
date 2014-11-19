require "spec_helper"
require 'webmock/rspec'

describe WheelmapApi do

	before do
		@location = create(:location, street: "Schanzenstr.", house_number: "85", zip: "20357", city: "Hamburg", wheelmap_id: 123)
	end

	before(:each) do
		Rails.cache.clear
	end

	%w(unknown limited no yes some_unexpected_string).shuffle.each do |possible_answer|
		it "returns a #{possible_answer}" do
			while_stubbing_result(possible_answer) do
				expect(@location.wheelchair_status).to eq(I18n.t("location.wheelchair_status.#{possible_answer}"))
			end
		end
	end

	it "doesn't ask the api twice within one hour" do 
		expect(WheelmapApi).to receive(:wheelbase_wheelchair_status).and_return("dontcare").once
		@location.wheelchair_status
		@location.wheelchair_status
	end

	it "does ask the api a second time after one hours" do 
		expect(WheelmapApi).to receive(:wheelbase_wheelchair_status).and_return("dontcare").twice
		@location.wheelchair_status

		Timecop.freeze(Time.now + 3601.seconds) do
			@location.wheelchair_status
		end
	end

	def while_stubbing_result( result )
		WebMock.reset!
		result_json = { node: { wheelchair: result } }.to_json
		stub_get = stub_request(:get, /wheelmap.org/).to_return(status: 200, body: result_json, headers: {})
		yield
	end

end