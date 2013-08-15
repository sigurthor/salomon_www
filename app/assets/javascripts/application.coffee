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
      undefined

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
    $('#product-list .product').bind 'click', ->
      $el = $(this)
      href = $el.find('h2 a').attr('href')
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


$(document).ready(salomon.initialize())