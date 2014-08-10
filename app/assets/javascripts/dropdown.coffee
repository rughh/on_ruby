class Dropdown

  constructor: (rootElement) ->
    @$rootElement = $(rootElement).on('click.dropdown', @toggle)
    @registerClose()

  toggle: (event) ->
    event.preventDefault()
    $(@).toggleClass('open')

  close: (event) ->
    unless $(event.target).parents('.dropdown').length
      @$rootElement.removeClass('open')

  registerClose: ->
    $('html').on 'click.dropdown', (event) =>
      @close(event)

$.fn.dropdown = ->
    @.each ->
      new Dropdown(@)

$('.dropdown').dropdown()
