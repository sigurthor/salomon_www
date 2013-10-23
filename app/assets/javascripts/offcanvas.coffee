do ($ = jQuery, window, document) ->

  pluginName = "offcanvas"
  defaults =
    maxWidth: false
    offcanvasWidth: false
    offcanvasSide: false
    elements:
      offcanvas: $ '#off-canvas'
      toggle: $ '.canvas-toggle'
      movable:
        body: $ '#main'
        topNav: $ '#top-nav'

  class Plugin
    constructor: (@element, options) ->
      @$element = $ element

      @settings = $.extend {}, defaults, options

      @_defaults = defaults
      @_name = pluginName

      @init()

    init: ->
      @updateSettings()
      @browserInfo()
      @attachEvents()
      @setHeight()

      return

    toggle: (e) ->
      if e
        e.preventDefault()

      if @state.open
        @close()
      else
        @open()

    open: ->
      @state.open = true

      if @settings.offcanvasSide is 'right'
        @setBodyPosition(-@settings.offcanvasWidth)
        @state.position = -@settings.offcanvasWidth
      else if @settings.offcanvasSide is 'left'
        @setBodyPosition(@settings.offcanvasWidth)
        @state.position = @settings.offcanvasWidth

      @settings.elements.offcanvas.css '-webkit-overflow-scrolling': 'touch'

    close: ->
      @state.open = false
      @setBodyPosition(0)
      @state.position = 0

      @settings.elements.offcanvas.css '-webkit-overflow-scrolling': ''

    setBodyPosition: (num) ->
      $.each @settings.elements.movable, $.proxy (index,el) ->
        $(el).css(if @browser.oldMobile then { left: num } else @css.translateX(num))
      , @

    updateSettings: ->
      unless @settings.offcanvasWidth
        @settings.offcanvasWidth = parseInt @settings.elements.offcanvas.css('width'), 10
      unless @settings.offcanvasSide
        @settings.offcanvasSide = if @settings.elements.offcanvas.css('left') is '0px' then 'left' else 'right'

    attachEvents: ->
      @settings.elements.toggle.on 'click', $.proxy @toggle, @

      @resizeTimeout = 0
      $(window).on('resize', $.proxy @onResize, @).resize()
      return

    onResize: (e) ->
      clearTimeout(@resizeTimeout)
      @resizeTimeout = setTimeout $.proxy ->
        @setHeight()

        @close()  if @state.open  if $(window).width() > @settings.maxWidth  if typeof @settings.maxWidth is "number" and @settings.maxWidth > 0

      , @, 100

    setHeight: ->
      windowHeight = $(window).innerHeight()
      height = -1

      if @browser.oldMobile
        windowHeight = $(document).height()
        height = @$element.height()
      else
        windowHeight = if window.innerHeight then window.innerHeight else $(window).height()
        height = windowHeight

      @settings.elements.offcanvas.height(height)

    browserInfo: ->
      @browser = {}

      @browser.agent = window.navigator.userAgent
      @browser.android = @browser.agent.indexOf 'Android '
      @browser.ios = @browser.agent.indexOf 'iOS '

      @browser.iosVersion = if @browser.ios > -1 then window.Number(@browser.agent.substr(@browser.ios + 3, 3).replace('_', '.')) else 0;
      @browser.androidVersion = if @browser.android > -1 then window.Number(@browser.agent.substr(@browser.android + 8, 3)) else 0;

      @browser.oldMobile = @browser.iosVersion is 4 or @browser.androidVersion is 2

      return

    state:
      open: false
      position: 0

    css:
      translateX: (value) ->
        {
          '-webkit-transform': 'translateX(' + value + 'px)'
          '-moz-transform': 'translateX(' + value + 'px)'
          '-ms-transform': 'translateX(' + value + 'px)'
          '-o-transform': 'translateX(' + value + 'px)'
          'transform': 'translateX(' + value + 'px)'
        }

  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))
