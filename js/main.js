(function() {
  var Main;

  Main = (function() {
    function Main() {
      this.vars();
      this.events();
      this.initScroll();
      this.describeSequence();
    }

    Main.prototype.vars = function() {
      this.maxScroll = -8000;
      this.frameDur = 1000;
      this.$cover = $('#js-cover');
      this.$coverPlace = $('#js-cover-place');
      this.$icon1 = $('#js-icon1 .box-icon__content');
      this.$icon2 = $('#js-icon2 .box-icon__content');
      this.$icon3 = $('#js-icon3 .box-icon__content');
      return this.$w = $(window);
    };

    Main.prototype.events = function() {};

    Main.prototype.describeSequence = function() {
      var dur, start;
      start = 1;
      dur = this.frameDur;
      this.coverTween = TweenMax.to(this.$cover, 1, {
        rotationY: 120,
        rotationX: 65,
        x: this.$w.width() / 6.4,
        y: -400,
        onUpdate: (function(_this) {
          return function() {
            var progress;
            progress = _this.coverTween.progress();
            if (progress > .285) {
              _this.$icon1.css({
                'z-index': 11
              });
            } else {
              _this.$icon1.css({
                'z-index': 1
              });
            }
            if (progress > .345) {
              _this.$icon2.css({
                'z-index': 11
              });
            } else {
              _this.$icon2.css({
                'z-index': 1
              });
            }
            if (progress > .407) {
              return _this.$icon3.css({
                'z-index': 11
              });
            } else {
              return _this.$icon3.css({
                'z-index': 1
              });
            }
          };
        })(this)
      });
      return this.controller.addTween(start, this.coverTween, dur);
    };

    Main.prototype.initScroll = function() {
      var it;
      this.scroller = new IScroll('#js-main', {
        probeType: 3,
        mouseWheel: true,
        deceleration: 0.001
      });
      document.addEventListener('touchmove', (function(e) {
        return e.preventDefault();
      }), false);
      this.controller = $.superscrollorama({
        triggerAtCenter: false,
        playoutAnimations: true
      });
      it = this;
      this.scroller.on('scroll', function() {
        return it.updateScrollPos(this, it);
      });
      return this.scroller.on('scrollEnd', function() {
        return it.updateScrollPos(this, it);
      });
    };

    Main.prototype.updateScrollPos = function(that, it) {
      (that.y < it.maxScroll) && (that.y = it.maxScroll);
      return it.controller.setScrollContainerOffset(0, -(that.y >> 0)).triggerCheckAnim(true);
    };

    Main.prototype.bind = function(func, context) {
      var bindArgs, wrapper;
      wrapper = function() {
        var args, unshiftArgs;
        args = Array.prototype.slice.call(arguments);
        unshiftArgs = bindArgs.concat(args);
        return func.apply(context, unshiftArgs);
      };
      bindArgs = Array.prototype.slice.call(arguments, 2);
      return wrapper;
    };

    Main.prototype.isFF = function() {
      return navigator.userAgent.toLowerCase().indexOf('firefox') > -1;
    };

    return Main;

  })();

  new Main;

}).call(this);
