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

    if $('#product-list').length
      self.initFilters()

    if $('#map-search-overlay').length
      self.initStoreLocator()

    if $('#product-list').length
      self.initProductList()

    if $('.product-details').length
      self.initProductPage()

    if $('.member-nav-wrapper').length
      self.initTeamNav()


    setTimeout () ->
        $('#play-overlay').fadeIn(4000)
      , 250
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
    # INSTANTIATE MIXITUP
    $("#product-list").mixitup
      layoutMode: "grid" # Start in list mode (display: block) by default
      effects: ["fade", "blur"] # List of effects
      listEffects: ["fade", "rotateX"] # List of effects ONLY for list mode

    #
    #				*	The desired behaviour of multi-dimensional filtering can differ greatly
    #				*	from project to project. MixItUp's built in filter button handlers are best
    #				*	suited to simple filter operations, so we will need to build our own handlers
    #				*	for this demo to achieve the precise behaviour we need.
    #
    $filters = $(".filter-list").find("li")
    dimensions = {}

    # Bind checkbox click handlers:
    $filters.on "click", (e) ->
      e.preventDefault()

      $t = $(this)
      dimension = $t.attr("data-dimension")
      filter = $t.attr("data-filter")

      unless dimensions.hasOwnProperty dimension
        dimensions[dimension] = "all"

      filterString = dimensions[dimension]
      if filter is "all"

        # If "all"
        unless $t.hasClass("active")

          # if unchecked, check "all" and uncheck all other active filters
          $t.addClass("active").siblings().removeClass "active"

          # Replace entire string with "all"
          filterString = "all"
        else

          # Uncheck
          $t.removeClass "active"

          # Emtpy string
          filterString = ""
      else

        # Else, uncheck "all"
        $t.siblings("[data-filter=\"all\"]").removeClass "active"

        # Remove "all" from string
        filterString = filterString.replace("all", "")
        unless $t.hasClass("active")

          # Check checkbox
          $t.addClass "active"

          # Append filter to string
          filterString = (if filterString is "" then filter else filterString + " " + filter)
        else

          # Uncheck
          $t.removeClass "active"

          # Remove filter and preceeding space from string with RegEx
          re = new RegExp("(\\s|^)" + filter)
          filterString = filterString.replace(re, "")

      # Set demension with filterString
      dimensions[dimension] = filterString

      # We now have two strings containing the filter arguments for each dimension:
      console.info dimensions

      dimensionsArr = $.map dimensions, (k, v) ->
        return [k]

      #
      #					*	We then send these strings to MixItUp using the filter method. We can send as
      #					*	many dimensions to MixitUp as we need using an array as the second argument
      #					*	of the "filter" method. Each dimension must be a space seperated string.
      #					*
      #					*	In this case, MixItUp will show elements using OR logic within each dimension and
      #					*	AND logic between dimensions. At least one dimension must pass for the element to show.
      #
      $("#product-list").mixitup "filter", dimensionsArr



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
