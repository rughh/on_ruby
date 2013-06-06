//= require jquery
//= require jquery_ujs
//= require navi
//= require utility
//= require custom
//= require map

$ ->
  new Navi().scroll()
  Utility.disable()
  Map.init()
