# set global log fn
# note we can't just set window.log = console.log because we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

Canvas = require \./canvas.ls
Config = require \./config.ls

socket = io!
keys = Config.get-keys!
reset!

down-key-ids = {}

$ \.typey .on \touchend, ->
  e = it.originalEvent
  for t in e.changedTouches
    socket.emit \keyup, down-key-ids[tid = t.identifier]
    delete down-key-ids[tid]

$ \.typey .on \touchstart, ->
  e = it.originalEvent
  reset! if is-reset = e.touches.length is 5
  for t in (ts = if is-reset then e.touches else e.changedTouches)
    t.x = t.pageX - t.target.offsetLeft
    t.y = t.pageY - t.target.offsetTop
    k = find-nearest-key t.x, t.y
    down-key-ids[t.identifier] = k.id
    dx = Math.round t.x - k.x
    dy = Math.round t.y - k.y
    socket.emit \keydown, k.id, { dx:dx, dy:dy }
  Canvas.plot-touches ts, \cyan
  false

function find-nearest-key x, y
  _.min keys, -> Math.sqrt((x - it.x) ** 2 + (y - it.y) ** 2)

function reset
  Canvas.clear!
  for k in keys
    Canvas.plot-dot k.x, k.y, 20, \red
    Canvas.print k.id, k.x, k.y, \white
