salomon.preloadImage = (images) ->
  imgObject = new Array()
  for img, index in images
    imgObject[index] = new Image()
    imgObject[index].src = img