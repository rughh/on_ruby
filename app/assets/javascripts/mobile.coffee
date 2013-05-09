//= require jquery
//= require jquery_ujs
//= require jquery.mobile
//= require map
//= require navi

$(document).bind 'pageinit', ->
  new Navi().scroll()
  Map.initMobile()
