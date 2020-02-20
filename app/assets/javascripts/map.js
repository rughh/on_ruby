class GMap {
  constructor(canvas) {
    this.canvas = canvas;
    this.init = this.canvas.data("init");
    this.data = this.canvas.data("map");
    this.mapOptions = {
      zoom: this.init.zoom,
      scrollwheel: false,
      streetViewControl: false,
      center: new google.maps.LatLng(this.init.lat, this.init.long),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
  }

  show() {
    const map = new google.maps.Map(this.canvas[0], this.mapOptions);
    let recentWindow = null;
    const contents = {};

    jQuery.each(this.data, function() {
      const position = new google.maps.LatLng(this.lat, this.long);
      const marker = new google.maps.Marker({position, map, title: this.name});
      let content = `<div class='info-window'><p><strong><a href='/locations/${this.slug}'>${this.name}</a></strong></br>`;
      content += `${this.street} ${this.house_number}</br>`;
      content += `${this.zip} ${this.city}</p>`;
      if (this.wheelmap_id) {
        content += `<p><img src='https://img.shields.io/wheelmap/a/${this.wheelmap_id}.svg'></p></div>`;
      }

      if (contents[position]) {
        contents[position] += content;
      } else {
        contents[position] = content;
      }
      google.maps.event.addListener(marker, 'click', function() {
        let infoWindow;
        if (recentWindow) { recentWindow.close(); }
        recentWindow = (infoWindow = new google.maps.InfoWindow({content: contents[marker.position]}));
        infoWindow.open(map, marker);
      });
    });
  }
}

$(function() {
  $(".map_canvas").each(function() { new GMap($(this)).show() });
});
