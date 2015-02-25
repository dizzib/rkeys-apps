# set global log fn
# note we can't just set window.log = console.log because we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

context = (canvas = $ \.typey>canvas .0).getContext \2d

$ \.typey .on \touchstart, ->
  e = it.originalEvent
  clear! if is-reset = (ts = e.touches).length is 3
  plot-touches ts, if is-reset then \white else \black
  false

## helpers

function clear
  context.clearRect 0, 0, canvas.width, canvas.height

function plot-point x, y, color
  context
    ..beginPath!
    ..arc x, y, 5, 0, 2 * Math.PI
    ..fillStyle = color
    ..fill!

function plot-touch t, color
  x = t.pageX - t.target.offsetLeft
  y = t.pageY - t.target.offsetTop
  plot-point x, y, color

function plot-touches touches, color
  for t in touches then plot-touch t, color
