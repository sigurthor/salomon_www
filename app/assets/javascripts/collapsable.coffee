do ($ = jQuery, window, document) ->

  pluginName = "collapsable"
  defaults =
    cssAnimation: false

  class Plugin
    constructor: (@element, options) ->
      @$element = $ @element

      @settings = $.extend {}, defaults, options

      @_defaults = defaults
      @_name = pluginName

      @init()

    init: ->
      @attachEvents()

    attachEvents: ->
      @$element.find('dt').on 'click', $.proxy (e) ->
        $itemEl = $(e.target)
        $itemEl.toggleClass('open')
        $itemEl.siblings('dt').removeClass('open')
        unless @settings.cssAnimation
          $itemEl.next('dd').stop().slideToggle(200)
          $itemEl.siblings('dt').next('dd:visible').stop().slideUp(200).find('dd:visible').stop().slideUp(200)
      , @

    yourOtherFunction: ->
      # some logic

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))
