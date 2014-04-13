(function() {
  var Main;

  Main = (function() {
    function Main() {
      this.vars();
      this.initScroll();
    }

    Main.prototype.vars = function() {
      return this.maxScroll = -8000;
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
