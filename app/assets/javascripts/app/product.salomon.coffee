initProductList = () ->
  $products = $('#product-list .product').each (index, product) ->
    $product = $(product)
    $product.find('.product-thumbs li a').on 'click', (e) ->
      $anchor = $(this)
      e.preventDefault()
      fullSizeImg = $(this).data 'fullsize'
      $product.find('.product-image').attr('src', fullSizeImg)
      $anchor.parent().addClass('selected').siblings().removeClass('selected')

initTechSizeInfo = ->
  self = this
  $tabs = $('ul.tabs li a')
  $tabs.on 'click', (e) ->
    e.preventDefault()
    $clicked = $(this)
    $clicked.parent().addClass('selected').siblings().removeClass('selected')
    variant = $clicked.data('variant')
    $tabContent = $('.tab-content')
    $tabContent.hide().filter('[data-variant="'+variant+'"]').show()

initTechListExpand = ->
  self = this

  $('ul.tech-list li a.expand').on 'click', (e) ->
    $button = $(this)
    $li = $button.parent()
    e.preventDefault()

    if $li.hasClass 'expanded'
      $li.removeClass 'expanded'
      $button.html('&#x002B;')
    else
      $li.addClass 'expanded'
      $button.html('&#x2421;')

initProductThumbnails = ->
  $thumbs = $('.product-thumbnails li')
  $thumbs.each () ->
    $el = $(this)
    newImg = $el.find('img').data('fullsize')
    $el.bind 'click', (e) ->
      e.preventDefault()
      $thumbs.removeClass('active')
      $(this).addClass('active')
      $('.product-main-image img').attr('src', newImg)

initProductColorPicker = ->
  self = this
  $('.imageset').each ->
    $el = $(this)
    imageSetIndex = $el.data 'imagesetindex'

    if typeof imageSet != 'undefined'
      set = imageSet[parseInt(imageSetIndex)]
      $el.bind 'click', (e) ->
        e.preventDefault()
        updateImageset(set)
        $el.parent().parent().find('li').removeClass 'selected'
        $el.parent().addClass 'selected'

initProductSizePicker = ->
  $('.board-sizes li a').on 'click', (e) ->
    $el = $(this)
    e.preventDefault()
    imageSrc = $el.data 'fullsize'
    $('.product-main-image img').attr('src', imageSrc)

    $el.parent().addClass('selected').siblings().removeClass('selected')

updateImageset = (set) ->
  self = this
  $mainImg = $('.product-main-image')
  $mainImg.removeClass 'loaded'

  # First image goes into the main spot...
  $mainImg.find('img').attr('onload', 'form5image.hasLoaded(this)').attr('src', set[0]);

  $thumbList = $('.product-thumbnails ul')
  $thumbList.html('')

  for img, i in set
    cssClass = ''
    cssClass = 'active' if i == 0

    imgTpl = '
            <li class="'+cssClass+'">
              <a href="#"><img src="'+ximg+'" data-fullsize="'+img+'" /></a>
              <a href="#">View ' + (i+1) + '</a>
            </li>'
    $thumbList.append imgTpl

  initProductThumbnails()

salomon.product = () ->
  if $('#product-list').length
    initProductList()

  if $('.product-details').length
    initProductThumbnails()
    initProductColorPicker()
    initProductSizePicker()
    initTechListExpand()
    initTechSizeInfo()