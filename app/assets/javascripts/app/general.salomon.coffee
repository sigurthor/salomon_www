salomon.general = () ->

  toggleScroll = () ->
    if $('body').css('overflow') == 'hidden'
      $('body').css 'overflow', 'visible'
    else
      $('body').css 'overflow', 'hidden'

  $('.footer-language-chooser, #footer-language-modal #cancel-button, .black-overlay').click ->
    toggleScroll()
    $('.black-overlay, #footer-language-modal').fadeToggle()

  $(document).keyup (e) ->
    if e.keyCode is 27 and $('#footer-language-modal').is(':visible')
      $('.black-overlay, #footer-language-modal').fadeOut()
      toggleScroll()

  $('.lang-list li').click ->
    $('.black-overlay, #footer-language-modal').toggle()
    toggleScroll()

    # $('body').on 'click', '#html5-lightbox-overlay', ->

  $("#contactForm").validationEngine()

  setTimeout () ->
    $('#play-overlay').fadeIn(4000)
  , 250

  $('.disable-on-click').bind 'click', (e) ->
    e.preventDefault()
    $(this).addClass('disabled').html('One moment...')
    e.preventDefault()


  $("li .team-member").click ->
    window.location = $(this).find("a").attr("href");

  setTimeout () ->
    $(".dropable iframe").hover ->
      if $(this).hasClass('twitter-follow-button')
        $('li.social.twitter').addClass('open');
      else
        $('li.social.facebook').addClass('open');
  , 3500

  $('.dropable').on 'mouseenter mouseleave', (e) ->
    if e.type == 'mouseenter'
      $(this).addClass('open')
    if e.type == 'mouseleave'
      $(this).removeClass('open')
