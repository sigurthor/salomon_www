@salomon =
  initialize: () ->
    self = this

    if $('.frontpage').length
      self.initNavbar()
    self.initSearch()
    $(document).foundation 'topbar'
    $(document).foundation 'forms'
    $(document).foundation 'dropdown', activeClass: 'open'

    if $('#map-canvas').length
      self.initMap()

    if $('.products').length
      self.initFilters()

    if $('#map-search-overlay').length
      self.initStoreLocator()

    if $('#product-list').length
      self.initProductList()

    if $('.product-details').length
      self.initProductPage()

    $('.navigation-buttons a').click ->
    console.log 'api'  

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
    $('.products').mixitup
      effects: ['fade', 'blur']
      easing: 'WindBack'
      transitionSpeed: 400
      multiFilter: true
      showOnLoad: 'men women'

  initStoreLocator: () ->
    $('#map-search-overlay .button.search').bind 'click', (e) ->
      e.preventDefault()
      $('#map-search-overlay').addClass 'compact'

  initProductList: () ->
    console.log 'initializing product list'
    $('#product-list .product').bind 'click', ->
      $el = $(this)
      href = $el.find('h2 a').attr('href')
      window.location = href

  initProductPage: ->
    $thumbs = $('.product-thumbnails li')
    $thumbs.each () ->
      $el = $(this)
      newImg = $el.find('img').data('fullsize')
      $el.bind 'click', (e) ->
        $thumbs.removeClass('active')
        $(this).addClass('active')
        $('.product-main-image').attr('src', newImg)


    $('.disable-on-click').bind 'click', (e) ->
      $(this).addClass('disabled').html('One moment...')
      e.preventDefault()

$(document).ready(salomon.initialize())