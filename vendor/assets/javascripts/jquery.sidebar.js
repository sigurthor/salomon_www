;(function ( $, window, document, undefined ) {

  var pluginName = "sidebar",
    defaults = {
      sideEl: $('.sidebar'),
      bodyEl: $('.body'),
      topNavEl: $('.top-nav'),
      toggleEl: $('.sidebar-toggle'),
      maxWidth: 1023,
      sideNavWidth: 260,
      sideNavSide: 'right',
      mouseDrag: false,
      toggleTriggerSize: 50,
      transitionDuration: 300
    };

  function Plugin( element, options ) {
    this.element = element;
    this.wrapEl = $(element);

    this.settings = $.extend( {}, defaults, options );

    this._defaults = defaults;
    this._name = pluginName;

    this.init();
  }

  Plugin.prototype = {

    init: function() {
      this.checkTouch();
      this.getBrowserInformation();
      this.attachEvents();
      this.setStyles();
      this.setHeight();
    },

    css3: {
      translateX: function(num){
        return {
          'transform': 'translateX('+ num +'px)',
          '-webkit-transform': 'translateX('+ num +'px)',
          '-moz-transform': 'translateX('+ num +'px)',
          '-ms-transform': 'translate('+ num +'px, 0)'
        };
      },
      transition: function(num){
        return {
          '-webkit-transition': 'opacity ' + num + 'ms, -webkit-transform ' + num + 'ms',
          '-moz-transition': 'opacity ' + num + 'ms, -moz-transform ' + num + 'ms',
          '-ms-transition': 'opacity ' + num + 'ms, -moz-transform ' + num + 'ms',
          '-o-transition': 'opacity ' + num + 'ms, -o-transform ' + num + 'ms',
          'transition': 'opacity ' + num + 'ms, transform ' + num + 'ms'
        };
      },
      backface: function(vis){
        return {
          '-webkit-backface-visibility': vis,
          '-moz-backface-visibility': vis,
          '-ms-backface-visibility': vis,
          '-o-backface-visibility': vis,
          'backface-visibility': vis
        };
      }
    },

    // States
    isOpen: false,
    isVisible: false,

    // Values
    sidePosition: 0,
    resizeTimeout: 0,

    attachEvents: function(){
      var documentEl = $(document);

      if(!this.isLegacy){
        this.settings.bodyEl[0].addEventListener('webkitTransitionEnd', $.proxy(this.onTransitionEnd, this), true);
        this.settings.bodyEl[0].addEventListener('mozTransitionEnd', $.proxy(this.onTransitionEnd, this), true);
        this.settings.bodyEl[0].addEventListener('MSTransitionEnd', $.proxy(this.onTransitionEnd, this), true);
        this.settings.bodyEl[0].addEventListener('transitionend', $.proxy(this.onTransitionEnd, this), true);

        this.settings.topNavEl[0].addEventListener('webkitTransitionEnd', $.proxy(this.onTransitionEnd, this), true);
        this.settings.topNavEl[0].addEventListener('mozTransitionEnd', $.proxy(this.onTransitionEnd, this), true);
        this.settings.topNavEl[0].addEventListener('MSTransitionEnd', $.proxy(this.onTransitionEnd, this), true);
        this.settings.topNavEl[0].addEventListener('transitionend', $.proxy(this.onTransitionEnd, this), true);
      }

      this.settings.toggleEl.on('click', $.proxy(this.toggle, this));
      documentEl.on('keydown', $.proxy(this.onKeyDown, this));

      $(window).on('resize', $.proxy(this.onResize, this)).resize();
    },

    onResize: function(e){
      clearTimeout(this.resizeTimeout)

      this.resizeTimeout = setTimeout($.proxy(function(){
        this.setHeight();

        if(typeof this.settings.maxWidth == "number" && this.settings.maxWidth > 0) {
          if($(window).width() > this.settings.maxWidth) {
            if(this.isOpen) this.close();
          }
        }
      },this),100)
    },

    setHeight: function(){
      var windowHeight = $(window).innerHeight();
      var height = -1;

      if(this.isAndroid2 || this.isIOS4) {
        windowHeight = $(document).height();
        height = this.wrapEl.height();
      } else {
        windowHeight = window.innerHeight ? window.innerHeight : $(window).height();
        height = windowHeight;
      }

      this.settings.sideEl.height(height);
    },

    toggle: function(e){
      e.preventDefault();

      if(!this.isOpen){
        this.open();
      } else {
        this.close();
      }
    },

    open: function(){
      this.show();

      if(this.settings.sideNavSide === 'right'){
        this.setBodyPosition(-this.settings.sideNavWidth);
        this.isOpen = true;
        this.sidePosition = -this.settings.sideNavWidth;
      } else if(this.settings.sideNavSide === 'left') {
        this.setBodyPosition(this.settings.sideNavWidth);
        this.isOpen = true;
        this.sidePosition = this.settings.sideNavWidth;
      }

      $('body').addClass('noscroll');


      this.settings.sideEl.css({
        '-webkit-overflow-scrolling': 'touch'
      });

      jQuery.event.trigger('sideNavOpen');
    },

    close: function(){

      if(this.sidePosition === 0) {
        this.hide();
      }

      this.setBodyPosition(0);
      this.isOpen = false;
      this.sidePosition = 0;

      $('body').removeClass('noscroll');

      this.settings.sideEl.css({
        '-webkit-overflow-scrolling': ''
      });

      jQuery.event.trigger('sideNavClose');
    },

    show: function(){
      if(this.isVisible)
        return;

      this.isVisible = true;
      this.settings.sideEl.css({
        'display': 'block'
      });

      jQuery.event.trigger('sideNavVisible');
    },

    hide: function(){
      this.settings.sideEl.css('display', 'none');
      this.isVisible = false;
      this.settings.sideEl.css({
        'display': 'none'
      });

      jQuery.event.trigger('sideNavHidden');
    },

    setBodyPosition: function(num){
      var cssObj = this.css3.translateX(num);

      if(this.isLegacy || this.isAndroid2)
        cssObj = { left: num };

      this.settings.bodyEl.css(cssObj);
      this.settings.topNavEl.css(cssObj);
    },

    setStyles: function(){

      var cssObj = this.css3.transition(this.settings.transitionDuration);
      var backVis = this.css3.backface('hidden');

      this.settings.sideEl.css({'width':this.settings.sideNavWidth});
      this.settings.sideEl.css(cssObj);
      this.settings.bodyEl.css(cssObj);
      this.settings.bodyEl.css(backVis);
      this.settings.bodyEl.css(backVis);

      this.settings.topNavEl.css(cssObj);
      this.settings.topNavEl.css(backVis);
      this.settings.topNavEl.css(backVis);

      if(this.settings.sideNavSide === 'right'){
        this.settings.sideEl.css({'left':'auto','right':'0'});
      } else {
        this.settings.sideEl.css({'left':'0','right':'auto'});
      }

    },

    onKeyDown: function(e){
      var code = (e.keyCode ? e.keyCode : e.which);

      if(code === 77)
        this.toggle();
    },

    onTransitionEnd: function(e){
      if(e.target !== this.settings.bodyEl[0])
        return;
      if(e.target !== this.settings.topNavEl[0])
        return;

      if(!this.isOpen &&
        (e.propertyName === 'transform' ||
        e.propertyName === '-webkit-transform' ||
        e.propertyName === '-moz-transform' ||
        e.propertyName === '-ms-transform' ||
        e.propertyName === '-ms-transform')) {
        this.hide();
      }
    },

    getBrowserInformation: function(){
      this.isLegacy = $('.lt-ie9').length > 0;

      var agent = window.navigator.userAgent;
      var android = agent.indexOf('Android ');
      var ios = agent.indexOf('OS ');


      this.iosVersion = ios > -1 ? window.Number(agent.substr(ios + 3, 3).replace('_', '.')) : 0;
      this.isIOS4 = this.iosVersion === 4;

      this.androidVersion = android > -1 ? window.Number(agent.substr(android + 8, 3)) : 0;
      this.isAndroid2 = this.androidVersion === 2;
    },

    checkTouch: function(){
      var touchClass = $('.touch');

      if(touchClass.length > 0){
        this.settings.isTouch = true;
      } else {
        this.settings.isTouch = false;
      }
    }
  };

  $.fn[pluginName] = function ( options ) {
    return this.each(function () {
      if (!$.data(this, "plugin_" + pluginName)) {
        $.data(this, "plugin_" + pluginName, new Plugin( this, options ));
      }
    });
  };

})( jQuery, window, document );