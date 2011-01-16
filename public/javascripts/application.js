function initialize_map() {
  var element = document.getElementById("map_canvas");
  if(!element) {
    return;
  }
  var data = $.parseJSON($(element).attr('data-map')).location;  
  var latlng = new google.maps.LatLng(data.lat, data.long);
  var myOptions = {
    zoom: 14,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(element, myOptions);
  
  var marker = new google.maps.Marker({
    position: new google.maps.LatLng(data.lat, data.long),
    map: map,
    title: data.name
  });

  var infowindow = new google.maps.InfoWindow({
      content: $('#map_info_content').html()
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker);
  });
}

function show_hide() {
  $(".toggle").click(function (){
    var name = $(this).attr('name');
    $(".toggle_" + name).toggle('slow');
    return false;
  });
}

$(document).ready(function(){
  initialize_map();
  show_hide();
});
