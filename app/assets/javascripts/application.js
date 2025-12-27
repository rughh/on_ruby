/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap.js
//= require vendor/jquery.collapser
//= require utility
//= require custom
//= require map

$(function() {
  Utility.disable();
});

$.fn.random = function() {
  return this.eq(Math.floor(Math.random() * this.length));
};
