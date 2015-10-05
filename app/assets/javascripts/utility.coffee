class Utility
  @disable: ->
    $('form').on 'click', 'input[data-disable]', (event) ->
      event.preventDefault()
      alert($(this).data('disable'))

window.Utility = Utility
