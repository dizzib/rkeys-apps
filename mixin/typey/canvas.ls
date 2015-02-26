context = (canvas = $ \.typey>canvas .0).getContext \2d

module.exports =
  clear: ->
    context.clearRect 0, 0, canvas.width, canvas.height

  plot-touches: (touches, color) ->
    for t in touches then plot-touch t, color

function plot-dot x, y, color
  context
    ..beginPath!
    ..arc x, y, 5, 0, 2 * Math.PI
    ..fillStyle = color
    ..fill!

function plot-touch t, color
  x = t.pageX - t.target.offsetLeft
  y = t.pageY - t.target.offsetTop
  plot-dot x, y, color
