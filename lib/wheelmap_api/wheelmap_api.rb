class WheelmapApi

  def self.wheelbase_wheelchair_status( node_id )

  	conn = Faraday.new(:url => 'http://wheelmap.org/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.get "/api/nodes/#{node_id}", { api_key: WHEELMAP_API_KEY }
    
    if response.status == 200
      return JSON.parse(response.body)["node"]["wheelchair"] # can be one of [yes, no, limited, unknown]
    end
    nil
  end

end