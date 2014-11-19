class Map
  @init: ->
    canvas = $(".map_canvas")
    if canvas.length
      new Map(canvas).show()

  constructor: (@canvas) ->
    @init = @canvas.data("init")
    @data = @canvas.data("map")
    @mapOptions =
      zoom: @init.zoom
      scrollwheel: false
      streetViewControl: false
      center: new google.maps.LatLng(@init.lat, @init.long)
      mapTypeId: google.maps.MapTypeId.ROADMAP

  show: ->
    map = new google.maps.Map(@canvas[0], @mapOptions)
    recentWindow = null
    contents = {}
    jQuery.each @data, ->
      position = new google.maps.LatLng(@lat, @long)
      marker = new google.maps.Marker(position: position, map: map, title: @name)
      content = "<div class='info-window'><p><strong><a href='/locations/#{@slug}'>#{@name}</a></strong></br>"
      content += "#{@street} #{@house_number}</br>"
      content += "#{@zip} #{@city}</br></p>"
      content += "<p>#{@wheelchair_status}</p></div>"
      if contents[position]
        contents[position] += content
      else
        contents[position] = content
      google.maps.event.addListener marker, 'click', ->
        recentWindow.close() if recentWindow
        recentWindow = infoWindow = new google.maps.InfoWindow(content: contents[marker.position])
        infoWindow.open map, marker

window.Map = Map
