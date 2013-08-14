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
    $('.product-thumbnail').each () ->
      $el = $(this)
      newImg = $el.find('img').data('fullsize')
      $el.bind
        mouseenter: (e) ->
          $('.product-main-image').attr('src', newImg)

    $('.disable-on-click').bind 'click', (e) ->
      $(this).addClass('disabled').html('One moment...')
      e.preventDefault()

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
  $('.member-nav-wrapper').css 'width', itemsTotalWidth
  $('.member-nav-wrapper').css 'margin-left', -Math.abs(viewportWidth / 2)
  console.log viewportWidth

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
