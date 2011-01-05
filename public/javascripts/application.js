function initialize_map() {
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

function show_hide() {
  $(".show_hide a").click(function (){
    var name = $(this).attr('name');
    $("#add_" + name).toggle('slow');
    return false;
  });
}

$(document).ready(function(){
  initialize_map();
  show_hide();
});