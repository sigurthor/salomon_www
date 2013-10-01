#= require 'app/salomon'
#= require 'app/general.salomon'
#= require 'app/footer.salomon'
#= require 'app/navbar.salomon'
#= require 'app/filters.salomon'
#= require 'app/product.salomon'
#= require 'app/storelocator.salomon'
#= require 'app/vimeo.salomon'
#= require 'app/videopage.salomon'
#= require 'app/team.salomon'
#= require 'app/newsletter.salomon'
#= require 'app/herovideo.salomon'
#= require 'app/language.salomon'
#= require 'app/mobilenav.salomon'
#= require 'html5lightbox'

$(document).ready ->

  $(document).foundation 'topbar'
  # $(document).foundation 'forms'
  $(document).foundation 'dropdown', activeClass: 'open'
  $(document).foundation 'section'

  salomon.navbar()
  salomon.general()
  salomon.footer()
  salomon.filters()
  #salomon.searchbar()
  salomon.product()
  salomon.storelocator()
  salomon.videopage()
  salomon.vimeo()
  salomon.team()
  salomon.newsletter()
  salomon.heroVideo()
  salomon.languageBar()
  salomon.mobilenav()
