var CGN = {
  ratio: 0,
  showKoelsch: function() {
    $("header h1 a").text("Kölsch.rb");
    $("header h2 a").text("De Kölsche Ruby Jecke");
  },
  showCologne: function() {
    $("header h1 a").text("Cologne.rb");
    $("header h2 a").text("Ruby User Group Cologne");
  }
};
$(document).ready(function() {
  $("header h1, header h2").mouseover(CGN.showKoelsch).mouseout(CGN.showCologne);
  $(".main").append("<div id='gem'><img src='/assets/labels/cologne/gem-glas.png'><div id='beer'></div></div><span><a href='#on_ruby' id='refill'>refill?</a></span>");
  CGN.beer_height = $("#gem").height();
  $(window).scroll(function() {
    CGN.ratio = $(window).scrollTop() / ($(document).height() - $(window).height());
    $("#beer").height((1 - CGN.ratio) * CGN.beer_height);
    $("#refill").css("opacity", CGN.ratio);
  });
});
