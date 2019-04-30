/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS206: Consider reworking classes to avoid initClass
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
var Scroll = (function() {
  let instance = undefined;
  Scroll = class Scroll {
    static initClass() {
      instance = null;
      this.historyCounter = 0;
      this.duration = 1000;
    }

    static possibleTouchDevice() {
     return (/android|ipod|iphone|ipad/gi).test(navigator.appVersion);
   }

    static animatePage() {
      return $('a[href*="#"]').click(event => {
        const { hash } = event.currentTarget;
        const $target = $(hash);
        const topOffset = $('#nav').height()*0.9;
        if ($target.length) {
          const top = $target.offset().top - topOffset;
          event.preventDefault();
          // Die position:fixed navbar flackert im Mobile Webkit beim
          // animierten Scrollen total fies!
          // quickfix: keine Animation unter iOS/Android:
          if (Scroll.possibleTouchDevice()) {
            window.scrollTo(0, top);
          } else {
            $('html,body,document').animate({scrollTop: top}, this.duration);
          }
        }
        if (window.history && window.history.pushState) {
          const url = /\#/.test(location.href) ? location.href.replace(/\#.+/, hash) : `${location.href}${hash}`;
          return window.history.pushState(
            {count: this.historyCounter},
            `page-${this.historyCounter}`, url);
        }
      });
    }

    static animateLabel() {
      if (!Scroll.possibleTouchDevice()) {
        const t = $(document).scrollTop();
        let opacity = (Math.pow(t, 3) / 1e7);
        if (opacity < 0) { opacity = 0; }
        if (opacity > 1) { opacity = 1; }
        return $('#nav .label').css('opacity', opacity);
      }
    }
  };
  Scroll.initClass();
  return Scroll;
})();

$(function() {
  Scroll.animatePage();
  Scroll.animateLabel();
  return $(window).scroll(Scroll.animateLabel);
});

