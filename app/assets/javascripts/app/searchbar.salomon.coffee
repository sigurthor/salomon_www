salomon.searchbar = () ->
  $('.searchbutton').bind "click", (e) ->
    e.preventDefault()
    $(this).toggleClass('active')
    $('.searchbar').toggleClass('active')
    $('input.search-input').focus()