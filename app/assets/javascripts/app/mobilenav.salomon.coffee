salomon.mobilenav = () ->
  $('#container').offcanvas
    sideEl: $('#off-canvas'),
    bodyEl: $('#main-wrap'),
    topNavEl: $('#nav-container'),
    toggleEl: $('.sidebar-toggle'),
    sideNavWidth: 220,
    sideNavSide: 'left'