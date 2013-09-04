salomon.languageBar = () ->
  # Language bar ignore button
  $('#language-bar .ignore').on 'click', (e) ->
    e.preventDefault()
    $('#language-bar').removeClass 'open'


  $('select#language').on 'change', ->
    lang = $(this).val()
    window.location = '/' + lang

  $('#language-bar .has-dropdown li, .ignore').click ->
    inThreeMonths = 60 * 60 * 24 * 90
    if $(this).hasClass('ignore')
      createCookie('defaultCountry', 'Global(en)', inThreeMonths)
      return
    country = $(this).find('a').text()
    createCookie('defaultCountry', country, inThreeMonths)

  if !readCookie 'defaultCountry'
    if $('.frontpage').length
      setTimeout () ->
        $('#language-bar').addClass 'open'
      , 1500
