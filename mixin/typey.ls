# set global log fn
# note we can't just set window.log = console.log because we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

C = require \./typey/canvas.ls

$ \.typey .on \touchstart, ->
  e = it.originalEvent
  C.clear! if is-reset = (ts = e.touches).length is 3
  C.plot-touches ts, if is-reset then \white else \black
  false
