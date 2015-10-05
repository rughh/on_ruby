#= require jquery
#= require jquery_ujs
#= require navi
#= require utility
#= require custom
#= require map
#= require dropdown
#= require peek
#= require peek/views/performance_bar

$ ->
  Utility.disable()
  Map.init()

$.fn.random = ->
  this.eq(Math.floor(Math.random() * this.length))
