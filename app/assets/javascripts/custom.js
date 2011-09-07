

// use hor as a namespace
var hor = {
  animateNavi: function() {
    var scrollY = $(document).scrollTop();
    var opacity = (scrollY - $('#logo').offset().top) * 0.005;
    if (opacity < 0) opacity = 0;
    else if (opacity > 1) opacity = 1;
    $('.logo').css('opacity', opacity);
  },

  initializeMap: function() {
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
        h    += data.zip    + ' ' + data.city

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
  },

  showHide: function() {
    $(".toggle").click(function (){
      var name = $(this).attr('name');
      $(".toggle_" + name).toggle('slow');
      return false;
    });
  },

  displayUsers: function() {
    jQuery.each($('.imagelist img'), function() {
      var lazy = this;
      var src = $(lazy).attr('src');
      var dataSrc = $(lazy).attr('data-src');
      if (src != dataSrc) {
        $(lazy).attr('src', dataSrc);
      }
    });
  },

  hitCounter: 0,

  scrollPage: function(hash, event) {
    $target = $(hash);
    if ($target.length) {
      event.preventDefault();
      var top = ($target.offset().top - 80);
      $('html, body').animate({scrollTop: top}, 1200);
      if (window.history && window.history.pushState) {
        var new_url = /\#/.test(location.href) ? location.href.replace(/\#.+/, hash) : (location.href + hash), stateObj = { count: hor.historyCounter };
        window.history.pushState(stateObj, 'page-' + hor.historyCounter, new_url);
      }
    }
  }
}

// READY!!!
$(document).ready(function(){
  $('a[href*="#"]').click(function(event) {
    hor.scrollPage(this.hash, event);
  });
  $(window).load(hor.animateNavi).scroll(hor.animateNavi);
  hor.initializeMap();
  hor.showHide();
  setTimeout('hor.displayUsers()', 500);
});
