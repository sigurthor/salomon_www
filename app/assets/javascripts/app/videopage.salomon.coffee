salomon.videopage = () ->
  self = this
  $('.load-videos').on 'click', (e) ->
    e.preventDefault()
    $button = $(this)

    $videos = $('#videos')
    offset = $videos.children().length
    limit = 4
    query = '/a2/feeds/videos.json?limit='+limit+'&offset='+offset

    $.get query, (videos) ->
      if videos.length
        for video in videos
          videoTpl = '
                        <div class="large-6 columns">
                          <div class="update-item vimeo" data-vimeo-id="'+video.item_id+'">
                            <div class="update-meta">
                              <i class="ss-icon ss-standard">video</i>
                              <p>'+video.title+'</p>
                              <div class="time-ago">'+video.realative_date+' ago</div>
                             </div>
                          <div class="img-wrapper">
                            <img src="'+video.image_url+'" onload="form5image.hasLoaded(this)">
                          </div>
                          <div class="video-player"></div>
                        </div>
                      '
          $videos.append videoTpl
        salomon.vimeo()

      else
        $button.remove()