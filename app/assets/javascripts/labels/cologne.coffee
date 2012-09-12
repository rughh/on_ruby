CGN =
  ratio: 0
  # header animation
  showKoelsch: ->
    $("header h1").text "Kölsch.rb"
    $("header h2").text "De Kölsche Ruby Jecke"

  showCologne: ->
    $("header h1").text "Cologne.rb"
    $("header h2").text "Ruby User Group Cologne"

$(document).ready ->
  # assign header animation listeners
  $("#title").mouseover(CGN.showKoelsch).mouseout CGN.showCologne
  # append custom markup for gem beer glas
  $(".main").append "<div id='gem'><img src='/assets/labels/cologne/gem-glas.png'><div id='beer'></div></div><span><a href='#on_ruby' id='refill'>refill?</a></span>"
  # animate gem beer glas
  CGN.beer_height = $("#gem").height()
  $(window).scroll ->
    CGN.ratio = $(window).scrollTop() / ($(document).height() - $(window).height())
    $("#beer").height (1 - CGN.ratio) * CGN.beer_height
    $("#refill").css "opacity", CGN.ratio

