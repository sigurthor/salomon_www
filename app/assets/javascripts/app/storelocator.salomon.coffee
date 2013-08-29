salomon.storelocator = () ->
  if $('#map-canvas').length
    initStoreLocator()


mapInit = () ->
  mapOptions =
    zoom: 2
    center: new google.maps.LatLng(0, 0)
    mapTypeId: google.maps.MapTypeId.ROADMAP
  return new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

renderStore = (store) ->
  itemTpl = """
    <li data-lat="{{lat}}" data-lng="{{lng}}">
    <h4>{{name}}</h4>
    <p>{{address}}</p>
    <p>{{zipcode}} {{city}}</p>
    <p>{{phone}}</p>
    <p>
    <a href="http://{{website}}" target="_blank">{{website}}</a>
    </p>
    </li>"""
  return Mustache.render itemTpl, store

setMapPosition = (location) ->
  position = new google.maps.LatLng(location[0], location[1])
  googleMap.setCenter position
  googleMap.setZoom 9

createMarker = (store) ->
  options =
    position: new google.maps.LatLng(store.lat, store.lng)
    title: store.name
    map: googleMap

  window.ab = options
  marker = new google.maps.Marker options

initStoreLocator = ->
  window.googleMap = mapInit()
  google.maps.event.addDomListener(window, 'load', window.googleMap)

  $overlay = $('#map-search-overlay')

  $overlay.find('.button.search').bind 'click', (e) ->
    e.preventDefault()

    query = $overlay.find('input#searchBox').val()

    if query
      unless $overlay.hasClass 'compact'
        $overlay.addClass 'compact'
      queryString = 'http://nikitaclothing.com/services/map/get_stores.json'

      $.get queryString,
        search_string: query
        radius: 50
        , (data) ->

          console.log data
          if data.error
            console.log data
          else

            setMapPosition(data.search_location)

            $results = $('ol#results')
            $results.html('')
            for store in data.stores
              $results.append renderStore(store)
              createMarker(store)