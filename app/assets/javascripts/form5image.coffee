@form5image =
  init: ->
    undefined

  hasLoaded: (img) ->
    parent = img.parentNode
    i = 0;
    while parent
      if parent.className.indexOf('img-wrapper') > -1
        if parent.className.indexOf('loaded') == -1
          parent.className += ' loaded'
          break
      break if i > 3
      i++
      parent = parent.parentNode

  preLoad: (images) ->
    for img in images
      img = new Image();
      img.src = url;

form5image.init()