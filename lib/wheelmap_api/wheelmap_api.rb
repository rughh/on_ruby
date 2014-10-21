require 'httparty'
class WheelmapApi
  include HTTParty

  def self.wheelbase_wheelchair_status( node_id )
  	uri = "http://wheelmap.org/api/nodes/#{node_id}?api_key=#{WHEELMAP_API_KEY}"
  	response = get( uri )
  	
  	if response.success?
  		return response["node"]["wheelchair"] # can be one of [yes, no, limited, unknown]
  	end
  	nil
  end
end