class Map
  @initMobile: ->
    $("#map-link").bind 'click', ->
      new Map($(".map_canvas")).show()

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
      content = "<span class='marker'><strong><a href='/locations/#{@slug}'>#{@name}</a></strong></br>#{@street} #{@house_number}</br>#{@zip} #{@city}</span>"
      if contents[position]
        contents[position] += "</br></br>#{content}"
      else
        contents[position] = content
      google.maps.event.addListener marker, 'click', ->
        recentWindow.close() if recentWindow
        recentWindow = infoWindow = new google.maps.InfoWindow(content: contents[marker.position])
        infoWindow.open map, marker

$ ->
  Map.init()

$(document).bind 'pageinit', ->
  Map.initMobile()
