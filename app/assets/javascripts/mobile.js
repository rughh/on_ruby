//= require jquery
//= require jquery_ujs
//= require jquery.mobile

$(document).bind('pageinit', function() {
  var map = $("#mobile_map");
  if (map) {
    var screenWidth = $(window).width();
    var relativeWidth = screenWidth - (screenWidth * 0.1);
    var url = map.data('url') + '&size=' + relativeWidth + 'x' + relativeWidth;
    map.html('<img src="' +  url + '" />');
  }
});
