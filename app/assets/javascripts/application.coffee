#= require jquery
#= require jquery_ujs
#= require navi
#= require utility
#= require custom
#= require map
#= require dropdown

$ ->
  Utility.disable()
  GMap.init()

$.fn.random = ->
  this.eq(Math.floor(Math.random() * this.length))
