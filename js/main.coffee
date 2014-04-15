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
    @$baseShadow = $('#js-base-shadow')
    @$bottomShadow = $('#js-bottom-shadow')
    @$leftPeel  = $('#js-left-peel')
    @$leftPeelInner  = @$leftPeel.children()
    @$rightPeel = $('#js-right-peel')
    @$rightPeelInner  = @$rightPeel.children()
    @$w = $(window)

  events:->

  describeSequence:->
    start = 1
    dur = @frameDur
    @leftPeelTween   = TweenMax.to @$leftPeel, 1, left: '-50%'
    @controller.addTween start, @leftPeelTween,  dur/2
    @leftPeelChildrenTween   = TweenMax.to @$leftPeelInner, 1, width: '100%'
    @controller.addTween start, @leftPeelChildrenTween,  dur/2

    @rightPeelTween   = TweenMax.to @$rightPeel, 1, left: '100%'
    @controller.addTween start, @rightPeelTween,  dur/2
    @rightPeelChildrenTween   = TweenMax.to @$rightPeelInner, 1, width: '100%'
    @controller.addTween start, @rightPeelChildrenTween,  dur/2

    start += dur
    dur = @frameDur
    @coverBaseShadowTween   = TweenMax.to @$baseShadow, 1, opacity: 1
    @coverBottomShadowTween = TweenMax.to @$bottomShadow, 1, opacity: .5
    @coverTween  = TweenMax.to @$cover, 1,
      rotationY: 120
      rotationX: 65
      x: @$w.width()/6.4
      y: -400
      onUpdate: =>
        progress = @coverTween.progress()
        if progress > .215
          @$icon1.css 'z-index': 11
        else
          @$icon1.css 'z-index': 1

        if progress > .255
          @$icon2.css 'z-index': 11
        else
          @$icon2.css 'z-index': 1

        if progress > .297
          @$icon3.css 'z-index': 11
        else
          @$icon3.css 'z-index': 1

    @controller.addTween start, @coverTween,              dur
    @controller.addTween start, @coverBaseShadowTween,    dur/2
    @controller.addTween start, @coverBottomShadowTween,  dur/2

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