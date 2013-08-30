init = () ->
  $nav = $('#nav-container')
  $(window).scroll ->
    offset = $('#language-bar').hasClass('open') ? 45 : 5
    if $nav.offset().top > offset
      unless $nav.hasClass 'sticky'
        $nav.addClass 'sticky'
    else
      if $nav.hasClass 'sticky'
        $nav.removeClass 'sticky'

salomon.navbar = () ->
  if $('body').hasClass 'frontpage'
    init()
