# set global log fn
# note we can't just set window.log = console.log because we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

context = ($ \.typey>canvas .0).getContext \2d

$ \.typey .on \touchstart, ->
  e = it.originalEvent
  t = e.touches.0
  x = t.pageX - t.target.offsetLeft
  y = t.pageY - t.target.offsetTop
  draw-point x, y
  false

function draw-point x, y
  context
    ..beginPath!
    ..arc x, y, 5, 0, 2 * Math.PI
    ..fillStyle = \white
    ..fill!
