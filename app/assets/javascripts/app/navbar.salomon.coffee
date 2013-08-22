init = () ->
  $nav = $('#nav-container')
  $(window).scroll ->
    if $nav.offset().top > 5
      unless $nav.hasClass 'sticky'
        $nav.addClass 'sticky'
    else
      if $nav.hasClass 'sticky'
        $nav.removeClass 'sticky'

salomon.navbar = () ->
  if $('body').hasClass 'frontpage'
    init()