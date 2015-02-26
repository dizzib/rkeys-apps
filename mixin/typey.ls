# set global log fn
# note we can't just set window.log = console.log because we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

Canvas = require \./typey/canvas.ls
Config = require \./typey/config.ls

socket = io!
keys = Config.get-keys!
reset!

$ \.typey .on \touchstart, ->
  e = it.originalEvent
  reset! if is-reset = e.touches.length is 5
  for t in (ts = if is-reset then e.touches else e.changedTouches)
    t.x = t.pageX - t.target.offsetLeft
    t.y = t.pageY - t.target.offsetTop
    k = find-nearest-key t.x, t.y
    log k.id
    #socket.emit \keydown, k.id
  Canvas.plot-touches ts, \cyan
  false

function find-nearest-key x, y
  _.min keys, -> Math.sqrt((x - it.x) ** 2 + (y - it.y) ** 2)

function reset
  Canvas.clear!
  for k in keys then Canvas.plot-dot k.x, k.y, \white
