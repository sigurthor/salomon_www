salomon.mobilenav = () ->
  $('#container').offcanvas
    maxWidth: 1023
    elements:
      offcanvas: $ '#off-canvas'
      toggle: $ '.canvas-toggle'
      movable:
        body: $ '#main-wrap'
        topNav: $ '#nav-container'
