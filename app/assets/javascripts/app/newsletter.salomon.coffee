salomon.newsletter = ->
  if $('body').hasClass 'frontpage'
    init()

init = () ->
  emailInput = $('input#email-input')
  $('.email-subscription input[type="submit"]').click ->
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
          $('.email-subscription').removeClass 'dark-input input-error'
          $('form.email-subscription').html('<div class="newsletter-success">Thank you for signing up.</div>')
        else
          $('.email-subscription').addClass 'dark-input input-error'
    return false
