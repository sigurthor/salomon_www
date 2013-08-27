salomon.vimeo = ->
  vimeoId = $('.vimeo').data 'vimeo-id'
  if vimeoId != ''
    $profile = $('.member-profile')
    $profile.addClass('video')
    $profile.css 'cursor', 'pointer'
  $('.vimeo').bind 'click', (e) ->
    $self = $(this)
    e.preventDefault();
    $self.find('.img-wrapper').hide()

    vimeoId = $self.data 'vimeo-id'

    if vimeoId != ''
      vimeoWidth = 540
      vimeoHeight = 304

      if ($self.data 'vimeo-width') != undefined
        vimeoWidth = $self.data 'vimeo-width'
        vimeoHeight = $self.data 'vimeo-height'

      player = '
                <iframe
                  src="http://player.vimeo.com/video/'+vimeoId+'?color=00a4d1&amp;autoplay=1"
                  width="' + vimeoWidth + '" height="' + vimeoHeight + '" frameborder="0"
                  webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'

      $self.find('.video-player').show()
      $self.find('.video-player').html(player)

      $self.unbind()
