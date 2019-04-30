/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
class Utility {
  static disable() {
    return $('form').on('click', 'input[data-disable]', function(event) {
      event.preventDefault();
      return alert($(this).data('disable'));
    });
  }
}

window.Utility = Utility;
