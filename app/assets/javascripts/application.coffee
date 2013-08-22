//= require visible

@salomon =
  preloadImages: (images) ->
    imgObject = new Array()
    for img, index in images
      imgObject[index] = new Image()
      imgObject[index].src = img

  initialize: () ->
    self = this

    if $('.frontpage').length
      self.initNavbar()
      self.clickableTeamMembers()

      setTimeout () ->
          $('#language-bar').addClass 'open'
        , 1500

    self.initSearch()
    $(document).foundation 'topbar'
    $(document).foundation 'forms'
    $(document).foundation 'dropdown', activeClass: 'open'
    $(document).foundation 'section'

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

    if $('body.team').length
      self.clickableTeamMembers()

    if $('body.team-member').length
      self.initTeamNav()

    if $('.vimeo').length
      self.initVimeo()

    if $('.video').length
      self.initVideoPage()

    setTimeout () ->
        $('#play-overlay').fadeIn(4000)
      , 250

    $('.disable-on-click').bind 'click', (e) ->
      e.preventDefault()
      $(this).addClass('disabled').html('One moment...')
      e.preventDefault()


    # Language bar ignore button
    $('#language-bar .ignore').on 'click', (e) ->
      e.preventDefault()
      $('#language-bar').removeClass 'open'

    #
    # Frontpage Video DEMO
    #
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

    self.preloadImages [
      '/assets/layout/salomon_snowboards-logo-white@2x.png' # Preload logo for hover state
    ]

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
    $filters = $(".filter-list li")

    executionUnblock = ->
      $filters.removeData 'executing'


    dimensions = {}

    readFilterHash = ->
      urlHash = window.location.hash
      if urlHash
        urlDimensions = urlHash.replace('#', '').split '|'
        filterArray = new Array()
        for dimension in urlDimensions
          matchName = /^(.+):/

          dimensionName = dimension.match(matchName)[0].replace(':', '')
          dimension = dimension.replace(matchName, '')

          filters = dimension.split '-'
          dimensionString = ''
          for filter, index in filters
            filter = 'filter-'+filter unless filter == 'all'
            dimensionString = dimensionString + ' ' + filter
          filterArray.push dimensionString

          dimensions[dimensionName] = dimensionString

        $('#product-list').mixitup('filter', filterArray)
        for filter in filterArray.join(' ').split(' ')
          if filter != 'all' && filter != 'filter-U'
            $el = $filters.filter('[data-filter*="'+filter+'"]')
            $el.siblings().filter('[data-filter="all"]').removeClass 'active'
            $el.addClass('active')

    $("#product-list").mixitup
      layoutMode: "grid"
      effects: ["fade", "blur"]
      transitionSpeed: 400
      onMixEnd: executionUnblock
      onMixLoad: readFilterHash

    $filters.on "click", (e) ->
      e.preventDefault()
      $t = $(this)
      return if $t.data 'executing'
      $filters.data 'executing', true

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

      if history.pushState
        historyString = ''
        for key, dim of dimensions
          historyString = historyString + key + ':' + dim.trim().replace(/\s/g, '-').replace(/filter-/g, '') + '|'
        historyString = historyString.replace(/(^\|)|(\|$)/g, '')
        history.pushState null, null, '#' + historyString

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
    $products = $('#product-list .product').each (index, product) ->
      $product = $(product)
      $product.find('.product-thumbs li a').on 'click', (e) ->
        $anchor = $(this)
        e.preventDefault()
        fullSizeImg = $(this).data 'fullsize'
        $product.find('.product-image').attr('src', fullSizeImg)
        $anchor.parent().addClass('selected').siblings().removeClass('selected')

  initProductPage: ->
    self = this

    self.initProductThumbnails()

    self.initProductColorPicker()
    self.initProductSizePicker()
    self.initTechListExpand()
    self.initTechSizeInfo()

  initTechSizeInfo: ->
    self = this
    $tabs = $('ul.tabs li a')
    $tabs.on 'click', (e) ->
      e.preventDefault()
      $clicked = $(this)
      $clicked.parent().addClass('selected').siblings().removeClass('selected')
      variant = $clicked.data('variant')
      $tabContent = $('.tab-content')
      $tabContent.hide().filter('[data-variant="'+variant+'"]').show()



  initTechListExpand: ->
    self = this

    $('ul.tech-list li a.expand').on 'click', (e) ->
      $button = $(this)
      $li = $button.parent()
      e.preventDefault()

      if $li.hasClass 'expanded'
        $li.removeClass 'expanded'
        $button.html('&#x002B;')
      else
        $li.addClass 'expanded'
        $button.html('&#x2421;')

  initProductThumbnails: ->
    $thumbs = $('.product-thumbnails li')
    $thumbs.each () ->
      $el = $(this)
      newImg = $el.find('img').data('fullsize')
      $el.bind 'click', (e) ->
        e.preventDefault()
        $thumbs.removeClass('active')
        $(this).addClass('active')
        $('.product-main-image img').attr('src', newImg)

  initProductColorPicker: ->
    self = this
    $('.imageset').each ->
      $el = $(this)
      imageSetIndex = $el.data 'imagesetindex'

      if typeof imageSet != 'undefined'
        set = imageSet[parseInt(imageSetIndex)]
        $el.bind 'click', (e) ->
          e.preventDefault()
          self.updateImageset(set)
          $el.parent().parent().find('li').removeClass 'selected'
          $el.parent().addClass 'selected'

  initProductSizePicker: ->
    $('.board-sizes li a').on 'click', (e) ->
      $el = $(this)
      e.preventDefault()
      imageSrc = $el.data 'fullsize'
      $('.product-main-image img').attr('src', imageSrc)

      $el.parent().addClass('selected').siblings().removeClass('selected')

  updateImageset: (set) ->
    self = this

    # First image goes into the main spot...
    $('.product-main-image img').attr('src', set[0]);

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
    vimeoId = $('.vimeo').data 'vimeo-id'
    if vimeoId != ''
      $profile = $('.member-profile')
      $profile.addClass('video')
      $profile.css 'cursor', 'pointer'
    $('.vimeo').bind 'click', (e) ->
      console.log 'video clicked'
      $self = $(this)
      e.preventDefault();
      $self.find('.img-wrapper').hide()

      vimeoId = $self.data 'vimeo-id'

      if vimeoId != ''
        vimeoWidth = 540
        vimeoHeight = 304

        if ($self.data 'vimeo-width') != undefined
          vimeoWidth = $self.data 'vimeo-width'
          vimeoHeight = $self.data 'vimeo-height'

        player = '
          <iframe
            src="http://player.vimeo.com/video/'+vimeoId+'?color=00a4d1&amp;autoplay=1"
            width="' + vimeoWidth + '" height="' + vimeoHeight + '" frameborder="0"
            webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'

        $self.find('.video-player').show()
        $self.find('.video-player').html(player)

        $self.unbind()


  clickableTeamMembers: () ->
    $("li .team-member").click ->
      window.location = $(this).find("a").attr("href");

  initTeamNav: () ->

    updateCurrentProfile = (name, description, quote_author, quote_title, country, city, image_url) ->
      $('.member-profile h2').html(name)
      $('.member-profile .profile-text p').html(description)
      $('.quote author').html(quote_author)
      $('.quote title').html(quote_title)
      $('.country.detail-value').html(country)
      $('.hometown.detail-value').html(city)
      $('.member-profile').css 'background-image', 'url(' + image_url + ')'

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
      console.log $('.team-nav li:first-child').offset().left
      console.log $('.team-nav li:last-child').offset().left

      if($(this).hasClass('hover-nav-left'))
        if $('.team-nav li:first-child').offset().left >= 20
          $('.member-nav-wrapper').css('left', $('.member-nav-wrapper').css('left'))
          return false


      viewportOffset = $('.member-nav-wrapper').css 'left'
      viewportOffset = parseInt(viewportOffset.replace('px', ''))


      if $(this).hasClass('hover-nav-left')
        hoverNavDirection = Math.abs(parseInt($('.member-nav-wrapper').css('margin-left'))) + 20
        console.log 'left'
      else
        hoverNavDirection = $(window).width() - (itemsTotalWidth / 2) - 20
        console.log 'right' + hoverNavDirection

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

    riderList = $('ul.team-nav')
    addRider = (name, country, image_url) ->
      riderList.append('
        <li class="has-overlay">
          <div class="nav-team-member img-zoom-hover">
            <img src="' + image_url + '" width="140" height="140">
            <div class="team-member-info">
              <h3>' + name + '</h3>
              <div class="team-member-country">' + country + '</div>
            </div>
          </div>
        </li>
          ')
      updateItemsTotalWidth()

    updateItemsTotalWidth = ->
      totalRiders = $('ul.team-nav li').size()
      slideWidth = 160 # A single rider slide (140px) width plus margin (20px)
      itemsTotalWidth = (totalRiders * slideWidth) - 20  # No margin after last element
      $('ul.team-nav').css 'width', itemsTotalWidth
      $('.member-nav-wrapper').css 'width', itemsTotalWidth
      $('.member-nav-wrapper').css 'margin-left', (-Math.abs(itemsTotalWidth / 2) + 'px').toString()

    lastCategory = $('span#pros-category')
    $('.category-switches span').click ->
      $('section#member-nav').addClass 'loading-category'
      riderList.empty()
      category = $(this).attr('id').replace('-category', '')
      url = '/team/' + category + '.json'
      $('.member-nav-wrapper').css 'left', '50%'
      lastCategory.removeClass('current-category')
      $(this).addClass('current-category')
      lastCategory = $(this)
      $.ajax
        type: "GET"
        url: url
        data:
          get_param: "value"
        dataType: "json"
        success: (container) ->
          for team in container
            for member in team.team_members
              addRider(member.name, member.country, member.thumb_image.url)
          $('section#member-nav').removeClass 'loading-category'


    slug = $('.member-profile h2').html().toUpperCase().trim()
    jQuery(document).ready ($) ->
      $('ul.team-nav li:contains("' + slug + '")').click()
    console.log slug
    # Rider list
    # .on rather than .click for targetting dynamic elements,
    # i.e. category change by user.
    $('ul.team-nav').on "click", "li", ->
      if lastItem != null
        lastItem.addClass 'has-overlay'
        lastItem.removeClass 'currently-selected-team-member'
      $(this).removeClass 'has-overlay'
      $(this).addClass 'currently-selected-team-member'

      $('section#member').addClass 'loading-member'

      currentItemIndex = $(this).index()
      lastItem = $(this)

      offset = (itemsTotalWidth - windowTotalWidth) / 2

      newLocation = 85 + itemsTotalWidth - ((currentItemIndex + 1) * slideWidth) - offset
      lastLocation = newLocation

      $(".member-nav-wrapper").css 'left', newLocation
      lastItemIndex = currentItemIndex

      # Change current profile info
      url = '/team.json'
      name = $(this).find('h3').html()
      $.ajax
        type: "GET"
        url: url
        data:
          get_param: "value"
        dataType: "json"
        success: (container) ->
          for team in container
            for member in team.team_members
              if member.name.trim() == name.trim()
                updateCurrentProfile(member.name, member.description, member.quote_author, member.quote_title, member.country, member.city, member.main_image.url)
                $('section#member').removeClass 'loading-member'
                riderDescriptionLength = $('.profile-text').text().length
                # It is unknown whether the newly selected profile description
                # text is long so we remove the class
                $('.profile-text p').removeClass 'long'
                if riderDescriptionLength > 230
                  $('.profile-text p').addClass 'long'

  initVideoPage: () ->
    self = this
    $('.load-videos').on 'click', (e) ->
      e.preventDefault()
      $button = $(this)

      $videos = $('#videos')
      offset = $videos.children().length
      limit = 4
      query = '/a2/feeds/videos.json?limit='+limit+'&offset='+offset

      $.get query, (videos) ->
        if videos.length
          for video in videos
            videoTpl = '
              <div class="large-6 columns">
                <div class="update-item vimeo" data-vimeo-id="'+video.item_id+'">
                  <div class="update-meta">
                    <i class="ss-icon ss-standard">video</i>
                    <p>'+video.title+'</p>
                    <div class="time-ago">'+video.realative_date+' ago</div>
                   </div>
                <div class="img-wrapper">
                  <img src="'+video.image_url+'">
                </div>
                <div class="video-player"></div>
              </div>
            '
            $videos.append videoTpl
          self.initVimeo()

        else
          $button.remove()


$(document).ready(salomon.initialize())
