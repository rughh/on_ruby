var HOR = {
  showHide: function() {
    $(".toggle").click(function(event) {
      event.preventDefault();
      var name = $(this).attr('name');
      $(".toggle_" + name).toggle('slow');
    });
  },
  displayUsers: function() {
    jQuery.each($('.imagelist img'), function() {
      var lazy = this;
      var src = $(lazy).attr('src');
      var dataSrc = $(lazy).attr('data-src');
      if (src !== dataSrc) {
        $(lazy).attr('src', dataSrc);
      }
    });
  },
  initializeMap: function() {
    jQuery.each($(".map_canvas"), function() {
      var init = $.parseJSON($(this).attr('data-init'));
      var myOptions = {
        zoom: init.zoom,
        center: new google.maps.LatLng(init.lat, init.long),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        scrollwheel: false
      };
      var map = new google.maps.Map(this, myOptions);
      var arr = $.parseJSON($(this).attr('data-map'));
      jQuery.each(arr, function() {
        var h, infoWindow, marker;
        marker = new google.maps.Marker({
          position: new google.maps.LatLng(this.lat, this.long),
          map: map,
          title: this.name
        });
        h = "<strong><a href='" + this.url + "'>" + this.name + "</a></strong></br>";
        h += "" + this.street + " " + this.house_number + "</br>";
        h += "" + this.zip + " " + this.city;
        infoWindow = new google.maps.InfoWindow({
          content: h
        });
        if (arr.length === 1) {
          infoWindow.open(map, marker);
        }
        google.maps.event.addListener(marker, 'click', function() {
          infoWindow.open(map, marker);
        });
      });
    });
  },
  hitCounter: 0,
  scrollPage: function(hash, event) {
    var $target = $(hash);
    if ($target.length) {
      event.preventDefault();
      var top = $target.offset().top - 80;
      $('html, body').animate({
        scrollTop: top
      }, 1200);
      if (window.history && window.history.pushState) {
        var new_url = /\#/.test(location.href) ? location.href.replace(/\#.+/, hash) : "" + location.href + hash;
        window.history.pushState({ count: HOR.historyCounter }, "page-" + HOR.historyCounter, new_url);
      }
    }
  },
  animateNavi: function() {
    var scrollY = $(document).scrollTop();
    var opacity = (scrollY - $('#logo').offset().top) * 0.005;
    if (opacity < 0) {
      opacity = 0;
    } else if (opacity > 1) {
      opacity = 1;
    }
    $('.logo').css('opacity', opacity);
  },
  moreList: function(name) {
    var elements = $(name + " ul li");
    if(elements.size() > 5) {
      elements.slice(5).hide();
      $("<p class='more'>[<a href='#'>Alle anzeigen</a>]</p>").insertAfter(name + " ul");
    }
    $(name + ' .more a').click(function(event) {
      event.preventDefault();
      $(name + " ul li").filter(":hidden").show();
      $(name + ' .more').hide();
    });
  }
};
$(document).ready(function() {
  $('a[href*="#"]').click(function(event) {
    HOR.scrollPage(this.hash, event);
  });
  HOR.showHide();
  HOR.initializeMap();
  HOR.moreList("#events");
  HOR.moreList("#undone");
  HOR.moreList("#done");
  setTimeout(HOR.displayUsers, 500);
  $(window).load(HOR.animateNavi).scroll(HOR.animateNavi);
  setTimeout(function(){$(".flash").slideToggle()}, 3000);
});
