salomon.footer = () ->
  $('.collapseable').each (index,item) ->

    $el = $(item);
    $titleEl = $el.find('h5');
    $listEl = $titleEl.next('ul');

    $titleEl.on 'click', (e) ->
      if $(window).width() <= '1023'
        $el.toggleClass 'open'
        $listEl.slideToggle()

    $(window).resize () ->
      if $(window).width() <= '1023' && !$el.hasClass('open')
        $listEl.hide()
      else
        $listEl.show()
    .resize()

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
