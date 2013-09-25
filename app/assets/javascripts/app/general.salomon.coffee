salomon.general = () ->


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
