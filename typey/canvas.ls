context = (canvas = $ \.typey>canvas .0).getContext \2d

module.exports = me =
  clear: ->
    context.clearRect 0, 0, canvas.width, canvas.height

  plot-dot: (x, y, r, color) ->
    context
      ..beginPath!
      ..arc x, y, r, 0, 2 * Math.PI
      ..fillStyle = color
      ..fill!

  plot-touches: (touches, color) ->
    for t in touches then me.plot-dot t.x, t.y, 5, color

  print: (text, x, y, color) ->
    size = if text.length < 3 then 25 else 18
    context
      ..font = "#{size}pt Calibri"
      ..fillStyle = color
      ..fillText text, x - 2 - (7 * text.length), y + 8
