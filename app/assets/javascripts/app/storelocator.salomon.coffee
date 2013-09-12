salomon.storelocator = () ->
  if $('#map-canvas').length
    initStoreLocator()

#
# Initialize the map
#
mapInit = () ->
  mapOptions =
    zoom: 2
    center: new google.maps.LatLng(0, 0)
    scrollwheel: false
    mapTypeId: google.maps.MapTypeId.ROADMAP
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
    position: new google.maps.LatLng(store.lat, store.lng)
    title: store.name
    map: googleMap
    storeId: store.id

  marker = new google.maps.Marker options

  # Marker click handler
  google.maps.event.addListener marker, 'click', ->
    googleMap.setZoom(15)
    googleMap.panTo marker.getPosition()
    storeId = marker.storeId
    $('#store-'+storeId).addClass('highlight').siblings().removeClass('highlight')

  return marker

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

    # Todo: implement error handling if request fails
    queryString = 'http://nikitaclothing.com/services/map/get_stores.json'
    $.get queryString,
      search_string: query
      radius: 50
    , (data) ->
        if data.error
          console.info 'Error from web service: ' + data.error
        else
          initMapPosition(data.search_location)
          $results = $('ol#results')
          $results.html('')
          for store in data.stores
            marker = createMarker(store)

            $store = $results.append renderStoreResult(store)

            $store = $('#store-'+store.id)

            # Attach the marker JS object to the DOM element
            $store.data 'marker', marker

            $store.on 'click', (e) ->
              $thisStore = $(this)

              e.preventDefault()
              thisMarker = $thisStore.data 'marker'
              googleMap.panTo thisMarker.getPosition()
              googleMap.setZoom 15

              $thisStore.addClass('highlight').siblings().removeClass('highlight')






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
renderStoreResult = (store) ->
  itemTpl = """
    <li id="store-{{id}}" data-lat="{{lat}}" data-lng="{{lng}}">
      <h4>{{name}}</h4>
      <p>{{address}}</p>
      <p>{{zipcode}} {{city}}</p>
      <p>{{phone}}</p>
      <p>
        <a href="http://{{website}}" target="_blank">{{website}}</a>
      </p>
    </li>
  """
  return Mustache.render itemTpl, store
