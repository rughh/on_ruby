//= require jquery
//= require jquery_ujs
//= require jquery.mobile
//= require navi
//= require utility
//= require map

$(document).bind 'pageinit', ->
  new Navi().scroll()
  Utility.disable()
  Map.initMobile()
