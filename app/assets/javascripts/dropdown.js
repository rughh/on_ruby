/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
class Dropdown {

  constructor(rootElement) {
    this.toggle = this.toggle.bind(this);
    this.$rootElement = $(rootElement);
    $('.dropdown-toggle', this.$rootElement).on('click.dropdown', this.toggle);
    this.registerClose();
  }

  toggle(event) {
    event.preventDefault();
    return this.$rootElement.toggleClass('open');
  }

  close(event) {
    if (!$(event.target).parents('.dropdown').length) {
      return this.$rootElement.removeClass('open');
    }
  }

  registerClose() {
    return $('html').on('click.dropdown', event => {
      return this.close(event);
    });
  }
}

$.fn.dropdown = function() {
    return this.each(function() {
      return new Dropdown(this);
    });
  };

$('.dropdown').dropdown();
