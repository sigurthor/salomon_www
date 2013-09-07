salomon.team = ->
  if $('body').hasClass 'team-member'
    init()

init = () ->
  totalRiders = $('ul.team-nav .current-team-nav-category li').size()
  windowTotalWidth = $(window).width()
  slideWidth = 160 # A single rider slide (140px) width plus margin (20px)
  itemsTotalWidth = (totalRiders * slideWidth) - 20  # No margin after last element
  leftRemaining = (itemsTotalWidth - windowTotalWidth) / 2
  rightRemaining = leftRemaining
  middle = Math.floor(totalRiders / 2)  # Find middle rider slide

  currentItemIndex = middle
  lastItemIndex = currentItemIndex
  lastItem = null

  lastDirection = 'middle'
  lastLocation = 32

  riderList = $('ul.team-nav .current-team-nav-category')

  updateItemsTotalWidth = ->
    totalRiders = $('ul.team-nav .current-team-nav-category li').size()
    slideWidth = 160 # A single rider slide (140px) width plus margin (20px)
    itemsTotalWidth = (totalRiders * slideWidth) - 20  # No margin after last element
    $('ul.team-nav').css 'width', itemsTotalWidth
    $('.member-nav-wrapper').css 'width', itemsTotalWidth
    $('.member-nav-wrapper').css 'margin-left', (-Math.abs(itemsTotalWidth / 2) + 'px').toString()

  updateCategoryNav = (selectedCategory) ->
    $('.current-category').removeClass('current-category')
    $(selectedCategory).addClass('current-category')


  $(window).resize ->
    windowTotalWidth = $(window).width()

  $(document).ready ->
    viewportWidth = itemsTotalWidth

  # Arrow nav (switch between riders one by one by clicking)
  $('.navigation-buttons a').on 'click', ->
    if $(this).hasClass('left-arrow')
      $('.team-nav li:nth-child(' + (currentItemIndex) + ')').click()
    else
      $('.team-nav li:nth-child(' + (currentItemIndex + 2) + ')').click()

  $('.navigation-buttons a').mouseenter ->
    if $(this).hasClass 'left-arrow'
      $('.prev-name').html $('.currently-selected-team-member').prev().find('h3').text()
    else
      $('.next-name').html $('.currently-selected-team-member').next().find('h3').text()

  # Hover nav
  $('.hover-buttons > div').mouseenter ->
    if itemsTotalWidth < $(window).width()
      return false

    viewportOffset = $('.member-nav-wrapper').css 'left'
    viewportOffset = parseInt(viewportOffset.replace('px', ''))


    if $(this).hasClass('hover-nav-left')
      hoverNavDirection = Math.abs(parseInt($('.member-nav-wrapper').css('margin-left'))) + 20
    else
      hoverNavDirection = $(window).width() - (itemsTotalWidth / 2) - 20

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

  $('.category-switches span').on 'click', ->
    updateCategoryNav($(this))

    nextCategory = 'nav-' + ($(this).attr 'id').replace('-category', '')
    $('.current-team-nav-category').removeClass('current-team-nav-category')
    $('#' + nextCategory).addClass 'current-team-nav-category'
    updateItemsTotalWidth()

  #
  # Make currently selected profile active. Couldn't this be done in the server template?
  #
  slug = $('.member-profile h2').html().toUpperCase().trim()
  $(document).ready ->
    requestedMember = $('ul.team-nav li:contains("' + slug + '")').addClass('currently-selected-team-member').removeClass('has-overlay').get(0)
    updatePosition(requestedMember)

  #
  # Updates the position of a selected team member and toggles active state
  #
  updatePosition = (elm) ->
    $elm = $(elm)

    $elm.removeClass('has-overlay').siblings().addClass('has-overlay')
    $elm.addClass('currently-selected-team-member').siblings().removeClass('currently-selected-team-member')
    currentItemIndex = $elm.index()
    lastItem = $elm

    offset = (itemsTotalWidth - windowTotalWidth) / 2

    newLocation = 85 + itemsTotalWidth - ((currentItemIndex + 1) * slideWidth) - offset
    lastLocation = newLocation

    if currentItemIndex < Math.floor(totalRiders / 2)
      newLocation = Math.min((Math.abs(parseInt($('.member-nav-wrapper').css('margin-left'))) + 20), newLocation)
    else
      newLocation = Math.max(($(window).width() - (itemsTotalWidth / 2) - 20), newLocation)

    if itemsTotalWidth > $(window).width()
      $(".member-nav-wrapper").css 'left', newLocation
    lastItemIndex = currentItemIndex


  # Rider list
  $('ul.team-nav li').click ->
    name = $(this).find('h3').text()
    name = name.trim().replace(' ', '-').toLowerCase()
    url = '/team/rider-' + name + '?ajax=true'
    $('section#member').addClass 'loading-member'
    $(this).removeClass('has-overlay').siblings().addClass('has-overlay')
    $('.currently-selected-team-member').removeClass('currently-selected-team-member')
    $(this).addClass('currently-selected-team-member').siblings()
    $.ajax
      type: 'GET'
      url:  url
      data:
        get_param: 'value'
      dataType: 'html'
      success: (page) ->
        $('section#member-body').replaceWith(page)
        if history.pushState
          history.pushState null, null, url.replace('?ajax=true', '')
        console.log $('.currently-selected-team-member').prev().find('h3').text()
        $('.prev-name').html($('.currently-selected-team-member').prev().find('h3').text())
        $('.next-name').html($('.currently-selected-team-member').next().find('h3').text())
        salomon.vimeo()
