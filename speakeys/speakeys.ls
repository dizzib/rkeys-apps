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

var longclick-timeout
$ \.speakeys>.send
  ..on \touchend ->
    clearTimeout longclick-timeout

  ..on \touchstart ->
    socket.emit \keyseq, $m.text! / ''
    longclick-timeout := setTimeout (-> socket.emit \keyseq, <[ Return ]>), 750ms
    false

$ \.speakeys>.start .on \click -> r.start!

function msg then $m.text it
