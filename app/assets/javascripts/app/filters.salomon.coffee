init = () ->
  $filters = $(".filter-list li")

  executionUnblock = ->
    $filters.removeData 'executing'

  dimensions = {}
  readFilterHash = ->
    urlHash = window.location.hash
    if urlHash
      urlDimensions = urlHash.replace('#', '').split '|'
      filterArray = new Array()
      for dimension in urlDimensions
        matchName = /^(.+):/

        dimensionName = dimension.match(matchName)[0].replace(':', '')
        dimension = dimension.replace(matchName, '')

        filters = dimension.split '-'
        dimensionString = ''
        for filter, index in filters
          filter = 'filter-'+filter unless filter == 'all'
          dimensionString = dimensionString + ' ' + filter
        filterArray.push dimensionString

        dimensions[dimensionName] = dimensionString

      $('#product-list').mixitup('filter', filterArray)
      for filter in filterArray.join(' ').split(' ')
        if filter != 'all' && filter != 'filter-U'
          $el = $filters.filter('[data-filter*="'+filter+'"]')
          $el.siblings().filter('[data-filter="all"]').removeClass 'active'
          $el.addClass('active')
    $('.lastproduct').show()

  $("#product-list").mixitup
    layoutMode: "grid"
    effects: ["fade", "blur"]
    transitionSpeed: 400
    onMixEnd: executionUnblock
    onMixLoad: readFilterHash

  $filters.on "click", (e) ->
    e.preventDefault()
    $t = $(this)
    return if $t.data 'executing'
    $filters.data 'executing', true

    dimension = $t.attr("data-dimension")
    filter = $t.attr("data-filter")

    unless dimensions.hasOwnProperty dimension
      dimensions[dimension] = "all"

    filterString = dimensions[dimension]
    if filter is "all"
      unless $t.hasClass("active")
        $t.addClass("active").siblings().removeClass "active"
      filterString = "all"
    else
      $t.siblings("[data-filter=\"all\"]").removeClass "active"
      filterString = filterString.replace("all", "")
      unless $t.hasClass("active")
        $t.addClass "active"
        filterString = filter
        $t.siblings().removeClass 'active'
        #filterString = (if filterString is "" then filter else filterString + " " + filter)
      else
        $t.removeClass "active"
        re = new RegExp("(\\s|^)" + filter)
        filterString = filterString.replace(re, "")

    if $t.parent().find('.active').length == 0
      $t.siblings("[data-filter=\"all\"]").addClass 'active'
      filterString = 'all'

    dimensions[dimension] = filterString
    dimensionsArr = $.map dimensions, (k, v) ->
      return [k]

    if history.pushState
      historyString = ''
      for key, dim of dimensions
        historyString = historyString + key + ':' + dim.trim().replace(/\s/g, '-').replace(/filter-/g, '') + '|'
      historyString = historyString.replace(/(^\|)|(\|$)/g, '')
      history.pushState null, null, '#' + historyString

    $("#product-list").mixitup "filter", dimensionsArr


  $('.clear-filters').bind 'click', (e) ->
    e.preventDefault()
    $filters.removeClass('active').filter("[data-filter=\"all\"]").addClass 'active'
    dimensions = {}
    $("#product-list").mixitup "filter", 'all'
    $("html, body").animate({ scrollTop: $('#filterbar').offset().top }, 500)

  $('.modify-filters').bind 'click', (e) ->
    e.preventDefault()
    $("html, body").animate({ scrollTop: $('#filterbar').offset().top }, 500)

salomon.filters = () ->
  if $('#product-list').length
    init()