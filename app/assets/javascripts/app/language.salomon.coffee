salomon.languageBar = () ->
  # Language bar ignore button
  $('#language-bar .ignore').on 'click', (e) ->
    e.preventDefault()
    $('#language-bar').removeClass 'open'
    $('body').removeClass 'top-panel-40'


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
    setTimeout () ->
      $('#language-bar').addClass 'open'
      $('body').addClass 'top-panel-40'
    , 1500

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