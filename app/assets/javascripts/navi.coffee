class Navi

  @historyCounter: 0

  duration: 1000
  offset:   80

  scroll: ->
    $('a[href*="#"]').click (event) =>
      hash   = event.currentTarget.hash
      target = $(hash)
      if target.length
        event.preventDefault()
        top = target.offset().top - @offset
        $("html, body").animate(scrollTop: top, @duration)
        if window.history and window.history.pushState
          url = if /\#/.test(location.href) then location.href.replace(/\#.+/, hash) else "#{location.href}#{hash}"
          window.history.pushState
            count: Navi.historyCounter,
            "page-#{Navi.historyCounter}", url

window.Navi = Navi
