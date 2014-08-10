class Dropdown

  constructor: (rootElement) ->
    @$rootElement = $(rootElement)
    $('.dropdown-toggle', @$rootElement).on('click.dropdown', @toggle)
    @registerClose()

  toggle: (event) =>
    event.preventDefault()
    @$rootElement.toggleClass('open')

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
