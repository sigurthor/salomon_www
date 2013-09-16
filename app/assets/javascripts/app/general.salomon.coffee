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
