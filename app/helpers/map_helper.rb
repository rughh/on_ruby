module MapHelper
  def static_map(*locations)
    options = {
      zoom:     12,
      sensor:   false,
      key:      'AIzaSyBskJCTxAU9UbH3qijy46oNtZ1-4ad14PM',
    }
    params =  options.collect { |k, v| "#{k}=#{v}" }
    params += locations.map { |l| "markers=#{l.lat},#{l.long}" }
    url = 'http://maps.googleapis.com/maps/api/staticmap'
    "#{url}?#{URI.escape(params.join('&'))}"
  end

  def single_map(location, init = { zoom: 14 })
    data = {
      map:  Array(location).to_json,
      init: location.attributes.merge(init).to_json,
    }
    content_tag :div, '', class: 'map_canvas', data: data
  end

  def map(locations, init = { zoom: 12 })
    init = Whitelabel[:location].merge(init)
    data = {
      map:  locations.to_json,
      init: init.to_json,
    }
    content_tag :div, '', class: 'map_canvas', data: data
  end
end
