function initialize() {
  var latlng = new google.maps.LatLng(53.561858,9.962021);
  var myOptions = {
    zoom: 14,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  element = document.getElementById("map_canvas");
  var map = new google.maps.Map(element, myOptions);
  
  var data = $.parseJSON($(element).attr('data-map')).location;
  new google.maps.Marker({
    position: new google.maps.LatLng(data.lat, data.long),
    map: map,
    title: data.name
  }); 
}

$(document).ready(function(){
  initialize();
});