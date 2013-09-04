salomon.general = () ->

  createCookie = (name, value, days) ->
    if days
      date = new Date()
      date.setTime date.getTime() + (days * 24 * 60 * 60 * 1000)
      expires = "; expires=" + date.toGMTString()
    else
      expires = ""
    document.cookie = name + "=" + value + expires + "; path=/"
  readCookie = (name) ->
    nameEQ = name + "="
    ca = document.cookie.split(";")
    i = 0

    while i < ca.length
      c = ca[i]
      c = c.substring(1, c.length)  while c.charAt(0) is " "
      return c.substring(nameEQ.length, c.length)  if c.indexOf(nameEQ) is 0
      i++
    null
  eraseCookie = (name) ->
    createCookie name, "", -1

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
    console.log($(".dropdown iframe"))
    $(".dropdown iframe").hover ->
      $(this).parents("li.social").trigger("hover");
  , 3500

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
