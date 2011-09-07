HOR =
  showHide: ->
    $(".toggle").click (event) ->
      event.preventDefault()
      name = $(this).attr 'name'
      $(".toggle_#{name}").toggle 'slow'
      
  displayUsers: ->
    jQuery.each $('.imagelist img'), ->
      lazy = this
      src = $(lazy).attr 'src'
      dataSrc = $(lazy).attr 'data-src'
      if src != dataSrc
        $(lazy).attr 'src', dataSrc
  
  initializeMap: ->
    jQuery.each $(".map_canvas"), ->
      init = $.parseJSON $(this).attr 'data-init'

      myOptions = {
        zoom: init.zoom,
        center: new google.maps.LatLng(init.lat, init.long),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        scrollwheel: false
      }
      map = new google.maps.Map this, myOptions

      arr = $.parseJSON $(this).attr 'data-map'
      
      jQuery.each arr, ->
        marker = new google.maps.Marker {
          position: new google.maps.LatLng(@lat, @long),
          map: map,
          title: @name
        }

        h  = "<strong><a href='#{@url}'>#{@name}</a></strong></br>"
        h += "#{@street} #{@house_number}</br>"
        h += "#{@zip} #{@city}"

        infoWindow = new google.maps.InfoWindow {content: h}

        if arr.length == 1
          infoWindow.open map, marker

        google.maps.event.addListener marker, 'click', ->
          infoWindow.open map, marker

  hitCounter: 0

  scrollPage: (hash, event) ->
    $target = $(hash)
    if $target.length
      event.preventDefault()
      top = $target.offset().top - 80
      $('html, body').animate {scrollTop: top}, 1200
      if window.history && window.history.pushState
        new_url  = if /\#/.test(location.href) then location.href.replace /\#.+/, hash else "#{location.href}#{hash}"
        stateObj = { count: HOR.historyCounter }
        window.history.pushState stateObj, "page-#{HOR.historyCounter}", new_url
        
  animateNavi: ->
    scrollY = $(document).scrollTop()
    opacity = (scrollY - $('#logo').offset().top) * 0.005
    if opacity < 0
      opacity = 0
    else if opacity > 1
      opacity = 1
    $('.logo').css 'opacity', opacity


$(document).ready ->
  $('a[href*="#"]').click (event) ->
    HOR.scrollPage @hash, event

  HOR.showHide()
  HOR.initializeMap()
  setTimeout HOR.displayUsers, 500
  $(window).load(HOR.animateNavi).scroll(HOR.animateNavi)
