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
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(element, myOptions);
    
    var arr = $.parseJSON($(element).attr('data-map'));
    jQuery.each(arr, function() {
      var data = this.location;

      var marker = new google.maps.Marker({
        position: new google.maps.LatLng(data.lat, data.long),
        map: map,
        title: data.name
      });
      
      var h = '<h1>' + data.name + "</h1><p>"
      h += data.street + ' ' + data.house_number + ' ' + ' in ' + data.zip + ' ' + data.city + '</p></p>'
      h += '<a href="' + data.url + '">' + data.url + '</a></p>'
      var infowindow = new google.maps.InfoWindow({
          content: h
      });
      
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

function initialize_tooltip() {
  $(".tooltip_trigger").tooltip();
}

$(document).ready(function(){
  initialize_map();
  show_hide();
  initialize_tooltip();
});
