initMap = ->
  mapInit = () ->
    mapOptions =
      zoom: 8
      center: new google.maps.LatLng(-34.397, 150.644)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)
  google.maps.event.addDomListener(window, 'load', mapInit)

initStoreLocator = ->
  $('#map-search-overlay .button.search').bind 'click', (e) ->
    e.preventDefault()
    $('#map-search-overlay').addClass 'compact'

salomon.storelocator = () ->
  if $('#map-canvas').length
    initMap()
    initStoreLocator()
