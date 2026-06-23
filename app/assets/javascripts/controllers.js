// Minimal controller registry — mirrors Stimulus conventions without the dependency.
// Files in controllers/ assign to Controllers['name'] = class { connect(el) {} }
const Controllers = {};

document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('[data-controller]').forEach(function(el) {
    const name = el.dataset.controller;
    if (Controllers[name]) new Controllers[name](el).connect();
  });
});
