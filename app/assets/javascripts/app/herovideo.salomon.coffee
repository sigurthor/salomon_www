salomon.heroVideo = () ->

  #
  # Frontpage Video DEMO
  #
  $('#play-overlay').bind 'click', (e) ->
    e.preventDefault()

    $video = $('#hero video')
    $overlay = $('#play-overlay')

    $hero = $('#hero')

    windowHeight = $(window).height()
    windowWidth = $(window).width()

    $video.remove()
    $hero.css 'background', 'black'
    $('#nav-container').addClass 'sticky'
    $('#play-overlay').fadeOut 1500

    videoHeight = Math.ceil(windowHeight - 150)
    videoWidth = Math.ceil(videoHeight / 9 * 16)
    videoHeight += 5

    if videoWidth > windowWidth
      videoWidth = windowWidth
      videoHeight = Math.ceil(videoWidth / 16 * 9)

    $hero.html('<div style="width:'+videoWidth+'px; height:'+videoHeight+'px; margin: 0 auto;"><div class="flex-video vimeo widescreen"><iframe src="//player.vimeo.com/video/70501536?color=00a4d1&amp;autoplay=1" width="1280" height="720" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div></div>')
    $hero.css 'height', videoHeight+'px'

  ###

  Old code that belongs to the demo (keeping, if we will control the video player ourselves)

  $('.demo #play-overlay').bind 'click', (e) ->
    e.preventDefault()
    $video = $('video')
    $videoEl = $('video').get(0)
    $videoEl.pause()

    $('#nav-container').addClass 'sticky'
    $('#play-overlay, video').fadeOut 1500, () ->
      $video.find('source').get(0).src = 'http://vimeo.com/70501536/download?t=1376686407&v=177689239&s=d4646d19567293ddb7b9188f87f82379';
      $videoEl.load()
      $video.removeClass 'ambient'

    $('#hero').css('height', '680px')

    setTimeout () ->
      $videoEl.play()
      $videoEl.muted = false
      $video.fadeIn(2500)
    , 2000
  ###