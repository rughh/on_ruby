class Scroll
  instance = null
  @historyCounter = 0
  @duration = 1000

  # Die position:fixed navbar flackert im Mobile Webkit beim
  # animierten Scrollen total fies!
  # quickfix: keine Animation unter iOS/Android:
  @uglyFlickeringBrowser = (/android|ipod|iphone|ipad/gi).test(navigator.appVersion)

  @animatePage: ->
    $('a[href*="#"]').click (event) =>
      hash = event.currentTarget.hash
      $target = $(hash)
      topOffset = $('#nav').height()*0.9
      if $target.length
        top = $target.offset().top - topOffset
        event.preventDefault()
        if @uglyFlickeringBrowser
          window.scrollTo(0, top)
        else
          $('html,body,document').animate(scrollTop: top, @duration)
      if window.history and window.history.pushState
        url = if /\#/.test(location.href) then location.href.replace(/\#.+/, hash) else "#{location.href}#{hash}"
        window.history.pushState
          count: @historyCounter,
          "page-#{@historyCounter}", url

  @animateLabel: ->
    t = $(document).scrollTop()
    opacity = (Math.pow(t,3) / 1e8)
    opacity = 0 if (opacity < 0)
    opacity = 1 if (opacity > 1)
    $('#nav .label').css('opacity', opacity)

$ ->
  Scroll.animatePage()
  Scroll.animateLabel()
  $(window).scroll(Scroll.animateLabel)

