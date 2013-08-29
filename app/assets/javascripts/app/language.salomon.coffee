salomon.languageBar = () ->
  # Language bar ignore button
  $('#language-bar .ignore').on 'click', (e) ->
    e.preventDefault()
    $('#language-bar').removeClass 'open'


  $('select#language').on 'change', ->
    lang = $(this).val()
    window.location = '/' + lang