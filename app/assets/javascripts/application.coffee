#= require 'app/salomon'
#= require 'app/general.salomon'
#= require 'app/navbar.salomon'
#= require 'app/filters.salomon'
#= require 'app/searchbar.salomon'
#= require 'app/product.salomon'
#= require 'app/storelocator.salomon'
#= require 'app/imagepreload.salomon'
#= require 'app/vimeo.salomon'
#= require 'app/videopage.salomon'
#= require 'app/team.salomon'

$(document).ready ->
  $(document).foundation 'topbar'
  $(document).foundation 'forms'
  $(document).foundation 'dropdown', activeClass: 'open'
  $(document).foundation 'section'

  salomon.navbar()
  salomon.general()
  salomon.filters()
  salomon.searchbar()
  salomon.product()
  salomon.storelocator()
  salomon.videopage()
  salomon.vimeo()
  salomon.team()

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
          emailInput.addClass 'dark-input input-success'
          $('form.email-subscription').html('<div class="newsletter-success">Thank you for signing up.</div>')
        else
          $('.email-subscription').addClass 'dark-input input-error'
        console.log response.status
    return false
