@salomon =
  initialize: () ->
    self = this

    if $('.frontpage').length
      self.initNavbar()

      setTimeout () ->
          $('#language-bar').addClass 'open'
        , 1500

    self.initSearch()
    $(document).foundation 'topbar'
    $(document).foundation 'forms'
    $(document).foundation 'dropdown', activeClass: 'open'

    if $('#map-canvas').length
      self.initMap()

    if $('#product-list').length
      self.initFilters()

    if $('#map-search-overlay').length
      self.initStoreLocator()

    if $('#product-list').length
      self.initProductList()

    if $('.product-details').length
      self.initProductPage()

    if $('.team-member').length
      self.clickableTeamMembers()

    if $('.member-nav-wrapper').length
      self.initTeamNav()

    if $('.vimeo').length
      self.initVimeo()

    setTimeout () ->
        $('#play-overlay').fadeIn(4000)
      , 250

    # Language bar ignore button
    $('#language-bar .ignore').on 'click', (e) ->
      e.preventDefault()
      $('#language-bar').removeClass 'open'


    # Play overlay for Vimeo
    $('#play-overlay').bind 'click', (e) ->
      e.preventDefault()
      $video = $('video')
      $videoEl = $('video').get(0)
      $videoEl.pause()

      $('#nav-container').addClass 'sticky'
      $('#play-overlay, video').fadeOut 1500, () ->
        $video.find('source').get(0).src = 'http://vimeo.com/70501536/download?t=1376686407&v=177689239&s=d4646d19567293ddb7b9188f87f82379';
        $videoEl.load()
        $video.removeClass 'ambient'

      $('#hero').css('height', '680px')

      setTimeout () ->
          $videoEl.play()
          $videoEl.muted = false
          $video.fadeIn(2500)
        , 2000

  initNavbar: () ->
    $nav = $('#nav-container')
    $(window).scroll ->
      if $nav.offset().top > 5
        unless $nav.hasClass 'sticky'
          $nav.addClass 'sticky'
      else
        if $nav.hasClass 'sticky'
          $nav.removeClass 'sticky'

  initSearch: () ->
    $('.searchbutton').bind "click", (e) ->
      e.preventDefault()
      $(this).toggleClass('active')
      $('.searchbar').toggleClass('active')
      $('input.search-input').focus()

  initMap: () ->
    mapInit = () ->
      mapOptions =
        zoom: 8
        center: new google.maps.LatLng(-34.397, 150.644)
        mapTypeId: google.maps.MapTypeId.ROADMAP
      map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)
    google.maps.event.addDomListener(window, 'load', mapInit)

  initFilters: () ->

    $("#product-list").mixitup
      layoutMode: "grid"
      effects: ["fade", "blur"]
      listEffects: ["fade", "rotateX"]

    $filters = $(".filter-list li")
    dimensions = {}

    $filters.on "click", (e) ->
      e.preventDefault()

      $t = $(this)
      dimension = $t.attr("data-dimension")
      filter = $t.attr("data-filter")

      unless dimensions.hasOwnProperty dimension
        dimensions[dimension] = "all"

      filterString = dimensions[dimension]
      if filter is "all"
        unless $t.hasClass("active")
          $t.addClass("active").siblings().removeClass "active"
        filterString = "all"
      else
        $t.siblings("[data-filter=\"all\"]").removeClass "active"
        filterString = filterString.replace("all", "")
        unless $t.hasClass("active")
          $t.addClass "active"
          filterString = (if filterString is "" then filter else filterString + " " + filter)
        else
          $t.removeClass "active"
          re = new RegExp("(\\s|^)" + filter)
          filterString = filterString.replace(re, "")

      if $t.parent().find('.active').length == 0
        $t.siblings("[data-filter=\"all\"]").addClass 'active'
        filterString = 'all'

      dimensions[dimension] = filterString

      dimensionsArr = $.map dimensions, (k, v) ->
        return [k]

      $("#product-list").mixitup "filter", dimensionsArr

    $('.clear-filters').bind 'click', (e) ->
      e.preventDefault()
      $filters.removeClass('active').filter("[data-filter=\"all\"]").addClass 'active'
      dimensions = {}
      $("#product-list").mixitup "filter", 'all'
      $("html, body").animate({ scrollTop: $('#filterbar').offset().top }, 500)

    $('.modify-filters').bind 'click', (e) ->
      e.preventDefault()
      $("html, body").animate({ scrollTop: $('#filterbar').offset().top }, 500)


  initStoreLocator: () ->
    $('#map-search-overlay .button.search').bind 'click', (e) ->
      e.preventDefault()
      $('#map-search-overlay').addClass 'compact'

  initProductList: () ->
    $('#product-list .mix').bind 'click', ->
      $el = $(this)
      href = $el.find('h2 a').attr('href')
      if href
        window.location = href


  initProductPage: ->
    self = this

    self.initProductThumbnails()

    # Add to cart button should disable on click
    $('.disable-on-click').bind 'click', (e) ->
      e.preventDefault()
      $(this).addClass('disabled').html('One moment...')
      e.preventDefault()

    self.initProductColorPicker()

  initProductThumbnails: ->
    $thumbs = $('.product-thumbnails li')
    $thumbs.each () ->
      $el = $(this)
      newImg = $el.find('img').data('fullsize')
      $el.bind 'click', (e) ->
        e.preventDefault()
        $thumbs.removeClass('active')
        $(this).addClass('active')
        $('.product-main-image').attr('src', newImg)

  initProductColorPicker: ->
    self = this

    $('.imageset').each ->
      $el = $(this)
      imageSetIndex = $el.data 'imagesetindex'
      set = imageSet[parseInt(imageSetIndex)]

      $el.bind 'click', (e) ->
        e.preventDefault()
        self.updateImageset(set)
        $el.parent().parent().find('li').removeClass 'selected'
        $el.parent().addClass 'selected'

  updateImageset: (set) ->
    self = this

    # First image goes into the main spot...
    $('.product-main-image').attr('src', set[0]);

    $thumbList = $('.product-thumbnails ul')
    $thumbList.html('')

    for img, i in set
      cssClass = ''
      cssClass = 'active' if i == 0

      imgTpl = '
        <li class="'+cssClass+'">
          <a href="#"><img src="'+img+'" data-fullsize="'+img+'" /></a>
          <a href="#">View ' + (i+1) + '</a>
        </li>'
      $thumbList.append imgTpl

    self.initProductThumbnails()

  initVimeo: () ->
    $('.vimeo').bind 'click', (e) ->
      $self = $(this)
      e.preventDefault();
      $self.find('.img-wrapper').hide()

      vimeoId = $self.data 'vimeo-id'

      player = '
        <iframe
          src="http://player.vimeo.com/video/'+vimeoId+'?color=00a4d1&amp;autoplay=1"
          width="540" height="304" frameborder="0"
          webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'

      $self.find('.video-player').show()
      $self.find('.video-player').html(player)

      $self.unbind()


  clickableTeamMembers: () ->
    $("body.team .team-member").click ->
      window.location = $(this).find("a").attr("href");

  initTeamNav: () ->
    totalRiders = $('ul.team-nav li').size()
    windowTotalWidth = $(window).width()
    slideWidth = 160 # A single rider slide (140px) width plus margin (20px)
    itemsTotalWidth = (totalRiders * slideWidth) - 20  # No margin after last element
    leftRemaining = (itemsTotalWidth - windowTotalWidth) / 2
    rightRemaining = leftRemaining
    middle = Math.floor(totalRiders / 2)  # Find middle rider slide

    currentItemIndex = middle
    lastItemIndex = currentItemIndex
    lastItem = null


    $(window).resize ->
      windowTotalWidth = $(window).width()

    $(document).ready ->
      viewportWidth = itemsTotalWidth

    # Click nav (arrows)
    $('.navigation-buttons a').click ->
      if $(this).hasClass('left-arrow')
        $('.team-nav li:nth-child(' + (currentItemIndex) + ')').click()
      else
        $('.team-nav li:nth-child(' + (currentItemIndex + 2) + ')').click()

    # Hover nav
    $('.hover-buttons > div').mouseenter ->
      if $(this).hasClass('hover-nav-left')
        hoverNavDirection = '75%'
      else
        hoverNavDirection = '25%'

      $('.member-nav-wrapper').css({
          left             : hoverNavDirection,
          WebkitTransition : 'all 3s ease-in-out',
          MozTransition    : 'all 3s ease-in-out',
          MsTransition     : 'all 3s ease-in-out',
          OTransition      : 'all 3s ease-in-out',
          transition       : 'all 3s ease-in-out'
      })
    $('.hover-buttons > div').mouseleave ->
      $('.member-nav-wrapper').css({
          left             : $('.member-nav-wrapper').css('left'),
          WebkitTransition : 'all .5s ease-in-out',
          MozTransition    : 'all .5s ease-in-out',
          MsTransition     : 'all .5s ease-in-out',
          OTransition      : 'all .5s ease-in-out',
          transition       : 'all .5s ease-in-out'
      })

    lastDirection = 'middle'
    lastLocation = 32

    # Rider list
    $('ul.team-nav li').click ->
      if lastItem != null
        lastItem.addClass 'has-overlay'
      $(this).removeClass 'has-overlay'

      currentItemIndex = $(this).index()
      lastItem = $(this)

      offset = (itemsTotalWidth - windowTotalWidth) / 2

      console.log 'difference: ' + newLocation - lastLocation

      newLocation = 85 + itemsTotalWidth - ((currentItemIndex + 1) * slideWidth) - offset
      lastLocation = newLocation

      console.log newLocation
      console.log lastLocation

      $(".member-nav-wrapper").css 'left', newLocation
      lastItemIndex = currentItemIndex

$(document).ready(salomon.initialize())
