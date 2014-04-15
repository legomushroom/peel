class Main
  constructor:->
    @vars()
    @events()
    @initScroll()
    @describeSequence()
  vars:->
    @maxScroll = -8000
    @frameDur = 1000
    @$cover = $('#js-cover')
    @$coverPlace = $('#js-cover-place')
    @$icon1 = $('#js-icon1 .box-icon__content')
    @$icon2 = $('#js-icon2 .box-icon__content')
    @$icon3 = $('#js-icon3 .box-icon__content')
    @$w = $(window)

  events:->

  describeSequence:->
    start = 1
    dur = @frameDur
    @coverTween  = TweenMax.to @$cover, 1,
      rotationY: 120
      rotationX: 65
      x: @$w.width()/6.4
      y: -400
      onUpdate: =>
        progress = @coverTween.progress()
        if progress > .285
          @$icon1.css 'z-index': 11
        else
          @$icon1.css 'z-index': 1

        if progress > .345
          @$icon2.css 'z-index': 11
        else
          @$icon2.css 'z-index': 1

        if progress > .407
          @$icon3.css 'z-index': 11
        else
          @$icon3.css 'z-index': 1

    @controller.addTween start, @coverTween, dur

  initScroll:->
    @scroller = new IScroll '#js-main',
      probeType: 3
      mouseWheel: true
      deceleration: 0.001
    document.addEventListener 'touchmove', ((e)-> e.preventDefault()), false
    @controller = $.superscrollorama
      triggerAtCenter: false
      playoutAnimations: true
    it = @
    @scroller.on 'scroll',    -> it.updateScrollPos this, it
    @scroller.on 'scrollEnd', -> it.updateScrollPos this, it

  updateScrollPos:(that, it)->
    (that.y < it.maxScroll) and (that.y = it.maxScroll)
    it.controller.setScrollContainerOffset(0, -(that.y>>0))
      .triggerCheckAnim(true)

  bind:(func, context) ->
    wrapper = ->
      args = Array::slice.call(arguments)
      unshiftArgs = bindArgs.concat(args)
      func.apply context, unshiftArgs
    bindArgs = Array::slice.call(arguments, 2)
    wrapper

  isFF:->
    navigator.userAgent.toLowerCase().indexOf('firefox') > -1

new Main