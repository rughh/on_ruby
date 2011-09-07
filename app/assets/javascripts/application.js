//= require jquery
//= require jquery_ujs
//= require_self
//= require humane

function initialize_map() {
  jQuery.each($(".map_canvas"), function() {
    var element = this;
    if(!element) {
      return;
    }
    var init = $.parseJSON($(element).attr('data-init'));
    var myOptions = {
      zoom: init.zoom,
      center: new google.maps.LatLng(init.lat, init.long),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scrollwheel: false
    };
    var map = new google.maps.Map(element, myOptions);
    
    var arr = $.parseJSON($(element).attr('data-map'));
    jQuery.each(arr, function() {
      var data = this;

      var marker = new google.maps.Marker({
        position: new google.maps.LatLng(data.lat, data.long),
        map: map,
        title: data.name
      });
      
      var h = '<strong><a href="' + data.url + '">' + data.name + '</a></strong></br>'
      h    += data.street + ' ' + data.house_number + '</br>'
      h    += data.zip + ' ' + data.city
      var infowindow = new google.maps.InfoWindow({
          content: h
      });
      if(arr.length == 1) {
        infowindow.open(map, marker);
      }
      
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map, marker);
      });
    });
  });

}

function show_hide() {
  $(".toggle").click(function (){
    var name = $(this).attr('name');
    $(".toggle_" + name).toggle('slow');
    return false;
  });
}

function display_users() {
  jQuery.each($('.imagelist img'), function() {
    var lazy = this;
    var src = $(lazy).attr('src');
    var dataSrc = $(lazy).attr('data-src');
    if (src != dataSrc) {
      $(lazy).attr('src', dataSrc);
    }
  });
}



// thx to appfertigung.de
var history_counter = 0;
var scrollPage = function(hash, event) {
  $target = $(hash);
  if ($target.length) {
    event.preventDefault();
    var top = ($target.offset().top - 80);
    $('html, body').animate({scrollTop:top}, 1200, 'easeInOutCubic');
    if (window.history && window.history.pushState) {
      var new_url = /\#/.test(location.href) ? location.href.replace(/\#.+/, hash) : (location.href + hash), stateObj = { count : history_counter };
      window.history.pushState(stateObj, 'page-' + history_counter, new_url);
    }
  }
};

var animateNavi = function() {
  var scrollY = $(document).scrollTop();
  var opacity = (scrollY - $('#logo').offset().top) * 0.005;
  if (opacity < 0) opacity = 0;
  else if (opacity > 1) opacity = 1;
  $('.logo').css('opacity', opacity);
};


$(document).ready(function(){
  $('a[href*="#"]').click(function(event) {
    scrollPage(this.hash, event);
  });
  $(window).load(animateNavi).scroll(animateNavi);
  initialize_map();
  show_hide();
  setTimeout('display_users()', 500);
});
