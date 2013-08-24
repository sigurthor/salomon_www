salomon.team = ->
  if $('body').hasClass 'team-member'
    init()

init = () ->
  updateCurrentProfile = (name, description, quote_author, quote_title, country, city, facebook, twitter, instagram, image_url) ->

    $('.member-details .facebook').show()
    $('.member-details .twitter').show()
    $('.member-details .instagram').show()

    $('.member-profile h2').html(name)
    $('.member-profile .profile-text p').html(description)
    $('.quote .author').html(quote_author)
    $('.quote .title').html(quote_title)
    $('.country .detail-value').html(country)
    $('.city .detail-value').html(city)
    $('.member-profile').css 'background-image', 'url(' + image_url + ')'

    if facebook
      $('.member-details .facebook span').html('/' + facebook)
      $('.member-details .facebook a').attr('href', 'http://facebook.com/' + facebook)
    else
      $('.member-details .facebook').hide()

    if twitter
      $('.member-details .twitter span').html('@' + twitter)
      $('.member-details .twitter a').attr('href', 'http://twitter.com/' + twitter)
    else
      $('.member-details .twitter').hide()

    if instagram
      $('.member-details .instagram span').html('@' + instagram)
      $('.member-details .instagram a').attr('href', 'http://instagram.com/' + instagram)
    else
      $('.member-details .instagram').hide()


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
  # What is the purpose of this code?
  $('.navigation-buttons a').on 'click', ->
    if $(this).hasClass('left-arrow')
      $('.team-nav li:nth-child(' + (currentItemIndex) + ')').click()
    else
      $('.team-nav li:nth-child(' + (currentItemIndex + 2) + ')').click()


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

  $('.category-switches span').on 'click', ->
    $('section#member-nav').addClass 'loading-category'
    riderList.empty()
    category = $(this).attr('id').replace('-category', '')
    url = '/team/' + category + '.json'
    $('.member-nav-wrapper').css 'left', '50%'
    $('.current-category').removeClass('current-category')
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


  #
  # Make currently selected profile active. Couldn't this be done in the server template?
  #
  slug = $('.member-profile h2').html().toUpperCase().trim()
  $(document).ready ->
    requestedMember = $('ul.team-nav li:contains("' + slug + '")').addClass('currently-selected-member').removeClass('has-overlay').get(0)
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
  # .on rather than .click for targetting dynamic elements,
  # i.e. after category change by user.
  $('ul.team-nav').on "click", "li", ->
    $('section#member').addClass 'loading-member'

    updatePosition(this)

    # Change current profile info
    category = null
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
              category = '#' + team.name.toLowerCase().trim()
              category += '-category'
              $(category).addClass('current-category')
              updateCurrentProfile(member.name, member.description, member.quote_author, member.quote_title, member.country, member.city, member.facebook, member.twitter, member.instragram, member.main_image.url)
              $('section#member').removeClass 'loading-member'
              riderDescriptionLength = $('.profile-text').text().length
              # It is unknown whether the newly selected profile description
              # text is long so we remove the class
              $('.profile-text p').removeClass 'long'
              if riderDescriptionLength > 230
                $('.profile-text p').addClass 'long'
              if !($('.video-player').is(':empty'))
                $('.video-player').empty()
              $profile = $('.member-profile')
              $profile.removeClass('video')
              newVideoID = member.video
              $profile.css 'cursor', 'auto'
              if newVideoID != ''
                $profile.addClass('video')
                $('.member-profile').data('vimeo-id', newVideoID)
                salomon.vimeo()
              if history.pushState
                url = '/team/rider-?team_member=' + name.replace(' ', '-').toLowerCase()
                history.pushState null, null, url

              # Until we get this in the json answer, remove it
              $('#gear-used').remove()
