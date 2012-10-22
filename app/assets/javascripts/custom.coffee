HOR =
  loginNote: ->
    $('form').on 'click', 'input[data-disable]', (event) ->
      event.preventDefault()
      alert($(this).data('disable'))

  showHide: ->
    $(".toggle").click (event) ->
      event.preventDefault()
      name = $(this).attr("name")
      $(".toggle_" + name).slideToggle()

  displayUsers: ->
    func = ->
      jQuery.each $(".imagelist img"), ->
        src = $(this).attr("src")
        dataSrc = $(this).attr("data-src")
        $(this).attr "src", dataSrc  if src isnt dataSrc
    setTimeout func, 500

  initializeMap: ->
    jQuery.each $(".map_canvas"), ->
      L.Icon.Default.imagePath = "/assets/map"
      init = $(this).data("init")
      cloudmadeUrl = "http://{s}.tile.cloudmade.com/b2b4845cfc774e478439692a106b4f26/997/256/{z}/{x}/{y}.png"
      cloudmade = new L.TileLayer(cloudmadeUrl,
        maxZoom: 18
      )
      mapOptions =
        center: new L.LatLng(init.lat, init.long)
        layers: [cloudmade]
        zoom: init.zoom
        scrollWheelZoom: false
        trackResize: false
        zoomAnimation: false
        fadeAnimation: false

      map = new L.Map(this, mapOptions)
      markers = {}
      arr = $(this).data("map")
      jQuery.each arr, ->
        h = undefined
        marker = undefined
        h = "<strong><a href='/locations/" + @slug + "'>" + @name + "</a></strong></br>"
        h += "" + @street + " " + @house_number + "</br>"
        h += "" + @zip + " " + @city
        ll = new L.LatLng(@lat, @long)
        unless markers[ll] is `undefined`
          popupContent = markers[ll]._popup._content
          markers[ll].bindPopup popupContent + "<br/><br/>" + h
        else
          marker = new L.Marker(ll).bindPopup(h)
          markers[ll] = marker
          map.addLayer marker

  scrollPage: ->
    $("a[href*=\"#\"]").click (event) ->
      target = $(@hash)
      if target.length
        event.preventDefault()
        top = target.offset().top - 80
        $("html, body").animate
          scrollTop: top
        , 1200
        if window.history and window.history.pushState
          new_url = (if /\#/.test(location.href) then location.href.replace(/\#.+/, @hash) else "" + location.href + @hash)
          window.history.pushState
            count: HOR.historyCounter
          , "page-" + HOR.historyCounter, new_url

  close: ->
    $(".close").click (event) ->
      event.preventDefault()
      $(this).parent().fadeOut()

  reload: ->
    $(".jobs").filter(":hidden").first().show()  if $(".jobs").filter(":visible").size() is 0
    $(".reload").click (event) ->
      event.preventDefault()
      first = $(".jobs").filter(":visible")
      first.hide()
      if first.next().length > 0
        first.next().fadeIn()
      else
        $(".jobs").filter(":hidden").first().fadeIn()

  moreList: (name) ->
    elements = $(name + " ul li")
    if elements.size() > 5
      elements.slice(5).hide()
      $("<p><a class='more' href='#'>" + I18n.showMore + "</a></p>").insertAfter name + " ul"
    $(name + " a.more").click (event) ->
      event.preventDefault()
      $(name + " ul li").filter(":hidden").fadeIn()
      $(name + " a.more").parent().hide()

$(document).ready ->
  HOR.loginNote()
  HOR.reload()
  HOR.close()
  HOR.showHide()
  HOR.scrollPage()
  HOR.moreList "#events"
  HOR.moreList "#undone"
  HOR.moreList "#done"
  HOR.moreList "#events_participated"
  HOR.moreList "#organized_events"
  HOR.moreList "#talks_done"
  HOR.moreList "#provided_material"
  HOR.moreList "#proposed_topics"
  HOR.displayUsers()
  HOR.initializeMap()
