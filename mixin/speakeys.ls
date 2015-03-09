ok = (R = window.webkitSpeechRecognition)?
return msg "Speech recognition not supported in this browser" unless ok

$m = $ \.speakeys>.msg
socket = io!

r = new R!
  ..onend = ->
    socket.emit \keydown, \speakeys-onend

  ..onerror = ->
    msg "Error: #{it.error}"

  ..onresult = ->
    msg it.results[*-1].0.transcript

  ..onstart = ->
    socket.emit \keydown, \speakeys-onstart
    msg 'Speak now!'

$ \.speakeys>.send  .on \click -> socket.emit \keyseq, $m.text! / ''
$ \.speakeys>.start .on \click -> r.start!

function msg then $m.text it
