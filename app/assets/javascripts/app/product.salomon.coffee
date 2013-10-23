initProductList = () ->
  $('.js-equalize').equalize {selector: '.js-equalize-me', responsive:true};

  $products = $('#product-list .product').each (index, product) ->
    $product = $(product)
    $product.find('.product-thumbs li a').on 'click', (e) ->
      $anchor = $(this)
      e.preventDefault()
      fullSizeImg = $(this).data 'fullsize'

      $product.find('.img-wrapper').removeClass 'loaded'
      $product.find('.product-image').attr('src', fullSizeImg)
      $anchor.parent().addClass('selected').siblings().removeClass('selected')

initTechSizeInfo = ->
  self = this
  $tabs = $('ul.tabs li a')
  $tabs.on 'click', (e) ->
    e.preventDefault()
    $clicked = $(this)
    $clicked.parent().addClass('selected loading').siblings().removeClass('selected')
    variant = $clicked.data('variant')
    $tabContent = $('.tab-content')
    setTimeout (->
      $('.selected').removeClass('loading')
      $tabContent.hide().filter('[data-variant="'+variant+'"]').show()
    ), 1000
initTechListExpand = ->
  self = this

  $('ul.tech-list li').on 'click', (e) ->
    $button = $(this).find('a.expand')
    $li = $(this)
    e.preventDefault()

    if $li.hasClass 'expanded'
      $li.find('.more').slideUp('400');
      setTimeout (->
        $li.removeClass 'expanded'
      ),400
      $button.html('&#x002B;')
    else
      $li.addClass 'expanded'
      $li.find('.more').slideDown('400');
      $button.html('&#x2421;')
initTechListWrapExpand = ->
  $('.js-expand-tech-list-wrap').on 'click', (e) ->
    e.preventDefault()
    $button = $(this)

    $('.tech-list-wrap').addClass 'expanded'
    $button.remove()

initProductThumbnails = ->
  $thumbs = $('.product-thumbnails li')
  $thumbs.each () ->
    $el = $(this)
    newImg = $el.find('img').data('fullsize')
    $el.bind 'click', (e) ->
      e.preventDefault()
      $thumbs.removeClass('active')
      $(this).addClass('active')

      $mainImg = $('.product-main-image')
      $imgTag = $mainImg.find('img')
      if $imgTag.attr('src') != newImg
        $mainImg.find('.img-wrapper').removeClass 'loaded'
        $mainImg.find('img').attr('src', newImg)

initProductColorPicker = ->
  self = this
  $('.imageset').each ->
    $el = $(this)
    imageSetIndex = $el.data 'imagesetindex'
    if typeof imageSet != 'undefined'
      set = imageSet[parseInt(imageSetIndex)]
      $el.bind 'click', (e) ->
        if $(this).parent().hasClass 'selected'
          return false
        e.preventDefault()
        updateImageset(set)
        $el.parent().parent().find('li').removeClass 'selected'
        $el.parent().addClass 'selected'
    $('ul.product-thumbs li:first-child').addClass('selected')

initProductSizePicker = ->
  $('.board-sizes li a').on 'click', (e) ->
    $el = $(this)
    e.preventDefault()
    imageSrc = $el.data 'fullsize'
    $mainImg = $('.product-main-image')
    $imgTag = $mainImg.find('img')
    if $imgTag.attr('src') != imageSrc
      $mainImg.find('.img-wrapper').removeClass 'loaded'
      $mainImg.find('img').attr('src', imageSrc)

    $el.parent().addClass('selected').siblings().removeClass('selected')

updateImageset = (set) ->
  self = this
  $mainImg = $('.product-main-image')
  $mainImg.find('.img-wrapper').removeClass 'loaded'

  # First image goes into the main spot...
  $mainImg.find('img').attr('src', set[0].fullsize);

  $thumbList = $('.product-thumbnails ul')
  $thumbList.html('')

  for img, i in set
    cssClass = ''
    cssClass = 'active' if i == 0

    imgTpl = '
            <li class="'+cssClass+'">
              <a href="#"><div class="img-wrapper" style="width: 80px; height: 80px;"><img src="'+img.thumb+'" data-fullsize="'+img.fullsize+'" width="80" height="80" onload="form5image.hasLoaded(this);" /></div></a>
              <a href="#">View ' + (i+1) + '</a>
            </li>'
    $thumbList.append imgTpl

  initProductThumbnails()


freezeScrollInLightbox = ->
  $('.product-gallery img').click ->
    $('body').css 'overflow', 'hidden'

  $('body').on 'click', '#html5-close', ->
    $('body').css 'overflow', 'visible'

  $('body').on 'click', '#html5-lightbox-overlay', ->
    $('body').css 'overflow', 'visible'

  $(document).keyup (e) ->
    if e.keyCode is 27
      $('body').css 'overflow', 'visible'

salomon.product = () ->

  $(document).ready ->
    if $('#product-list').length
      initProductList()

    if $('.product-details').length
      initProductThumbnails()
      initProductColorPicker()
      initProductSizePicker()
      initTechListExpand()
      initTechListWrapExpand()
      initTechSizeInfo()
      freezeScrollInLightbox()
