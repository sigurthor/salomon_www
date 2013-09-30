salomon.languageBar = () ->
  # Language bar ignore button
  $('#language-bar .ignore').on 'click', (e) ->
    e.preventDefault()
    $('#language-bar').removeClass 'open'
    $('body').removeClass 'top-panel-40'


  $('select#language').on 'change', ->
    lang = $(this).val()
    window.location =  lang

  $('.ignore').click ->
    inThreeMonths = 60 * 60 * 24 * 90
    if $(this).hasClass('ignore')
      createCookie('show_bar',0, inThreeMonths)
      createCookie('user_locale', readCookie('current_locale'), inThreeMonths)

  if show_bar()
    setTimeout () ->
      $('#language-bar').addClass 'open'
      $('body').addClass 'top-panel-40'
    , 1500

  footerLangSelector()

show_bar = () ->
  (readCookie('user_locale') != readCookie('current_locale')) || (readCookie('show_bar') == '1')

footerLangSelector = ->
  $('footer .language-selector a.button, footer .cancel-button').click ->
    $('footer .f-dropdown').toggleClass 'enabled'

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
