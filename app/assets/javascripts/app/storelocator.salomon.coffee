salomon.storelocator = () ->
  $('.js-equalize').equalize {selector: '.js-equalize-me', responsive:true};
  if $('#map-canvas').length
    initStoreLocator()

salomon.map = {}
salomon.map.markers = []

#
# Initialize the map
#
mapInit = () ->
  mapOptions =
    zoom: 2
    center: new google.maps.LatLng(0, 0)
    scrollwheel: false
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoomControlOptions:
      position: google.maps.ControlPosition.RIGHT_TOP
    panControlOptions:
      position: google.maps.ControlPosition.RIGHT_TOP

  return new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

#
# Initializes the position of the map based on location info from JSON result
#
initMapPosition = (location) ->
  position = new google.maps.LatLng(location[0], location[1])
  googleMap.setCenter position
  googleMap.setZoom 9

#
# Creates a marker on the map
#
createMarker = (store) ->
  options =
    position: new google.maps.LatLng(store.latitude, store.longitude)
    title: store.name
    map: googleMap
    storeId: store.id
    icon: 'https://maps.google.com/mapfiles/ms/icons/red-dot.png'

  marker = new google.maps.Marker options

  # Marker click handler
  google.maps.event.addListener marker, 'click', ->
    googleMap.setZoom(15)
    googleMap.panTo marker.getPosition()
    highlightResult(marker.storeId)
    highlightMarker(marker)

  salomon.map.markers.push marker
  return marker

#
# Highlights the result and sets scrollTop
#
highlightResult = (storeId) ->
  $storeEl = $('#store-'+storeId)
  $storeEl.addClass('highlight').siblings().removeClass('highlight')
  $results = $('ol#results')
  storePos = Math.abs($results.scrollTop()+$storeEl.offset().top-$results.offset().top)
  $('ol#results').animate(scrollTop:storePos, 300)

#
# Highlights the selected marker
#
highlightMarker = (marker) ->
  defaultIcon = new google.maps.MarkerImage('http://google.com/mapfiles/ms/micons/red-dot.png', new google.maps.Size(32,32))
  highlightIcon = new google.maps.MarkerImage('http://google.com/mapfiles/ms/micons/blue-dot.png', new google.maps.Size(32,32))
  for gmarker in salomon.map.markers
    gmarker.setIcon(defaultIcon)
    gmarker.setAnimation(null)

  marker.setIcon highlightIcon
  marker.setAnimation(google.maps.Animation.DROP)

#
# Search for stores
#
searchStores = (e) ->
  e.preventDefault()
  $overlay = $('#map-search-overlay')

  query = $overlay.find('input#searchBox').val()
  if query
    unless $overlay.hasClass 'compact'
      $overlay.addClass 'compact'

    $('ol#results').html('')
    for gmarker in salomon.map.markers
      gmarker.setMap(null)

    queryBackend query, parseResults


#
# Query the search backend and hand the results over to the given callback
#
queryBackend = (query, cb) ->
  # Todo: implement error handling if request fails

  updateState searching: 1
  #queryString = 'http://nikitaclothing.com/services/map/get_stores.json'
  queryString = 'http://www.salomonsnowboards.com/a2/services/map.json'
  $.get queryString,
    search_string: query
    radius: 50
  , (data) ->
    if data.error
      updateState notfound: 'No stores were found'
    else
      cb data

#
# Generates excel like column names (A, B ... AB, AC)
#
num2alpha = (n) ->
  r = ""
  while n >= 0
    r = String.fromCharCode(n % 26 + 0x41) + r
    n = parseInt(n / 26) - 1
  return r

#
# Parse results
#
parseResults = (data) ->
  initMapPosition(data.search_location)
  $results = $('ol#results')

  updateState found: 1

  i = 0;
  for store in data.stores
    marker = createMarker(store)
    $store = $results.append renderStoreResult(store, num2alpha(i++))
    $store = $('#store-'+store.id)

    # Attach the marker JS object to the DOM element
    $store.data 'marker', marker

    $store.on 'click', (e) ->
      $thisStore = $(this)
      thisMarker = $thisStore.data 'marker'
      googleMap.panTo thisMarker.getPosition()
      googleMap.setZoom 15
      highlightResult(thisMarker.storeId)
      highlightMarker(thisMarker)

#
# Handles search states
#
updateState = (options) ->
  $overlay = $('#map-search-overlay')
  if options.error
    console.log 'Error searching'
  else if options.notfound
    $overlay.find('.loading').hide()
    $overlay.find('.state-notfound').show()
  else if options.searching
    $overlay.find('.state-notfound').hide()
    $overlay.find('.loading').show()
  else if options.found
    $overlay.find('.loading').hide()
    $overlay.find('.state-notfound').hide()



#
# Initialize the store locator
#
initStoreLocator = ->
  window.googleMap = mapInit()
  google.maps.event.addDomListener(window, 'load', window.googleMap)

  $overlay = $('#map-search-overlay')
  $overlay.find('.button.search').bind 'click', searchStores
  $overlay.find('input#searchBox').focus()


# Template rendering functions

#
# Returns a rendered row for the search results
#
renderStoreResult = (store, num) ->
  itemTpl = """
    <li id="store-{{id}}" data-lat="{{latitude}}" data-lng="{{longitude}}" data-num="{{num}}">
      <h4>{{name}}</h4>
      <p>{{address}}</p>
      <p>{{postal_code}} {{city}}</p>
      <p>{{phone}}</p>
      <p>
        <a href="http://{{url}}" target="_blank">{{url}}</a>
      </p>
    </li>
  """
  store.num = num
  return Mustache.render itemTpl, store
