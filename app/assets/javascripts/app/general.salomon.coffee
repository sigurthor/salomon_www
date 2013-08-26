salomon.general = () ->
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

  $("li .team-member").click ->
    window.location = $(this).find("a").attr("href");

  if $('.frontpage').length
    setTimeout () ->
      $('#language-bar').addClass 'open'
    , 1500


  # Footer e-mail subscription

  emailInput = $('input#footer-email-input')
  $('.footer-email-subscription input[type="submit"]').click ->
    email = emailInput.val()
    $.ajax
      type: 'GET'
      url: '/a2/services/news_letter_signup.json?email=' + email
      data:
        get_param: 'value'
      dataType: 'json'
      success: (response) ->
        emailInput.removeClass('input-success dark-input input-error')
        if response.status == 'success'
          $('.footer-email-subscription').removeClass 'dark-input input-error'
          $('form.footer-email-subscription').html('<div class="newsletter-success">Thank you for signing up.</div>')
        else
          $('.footer-email-subscription').addClass 'dark-input input-error'
    return false
