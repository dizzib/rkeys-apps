ok = (R = window.webkitSpeechRecognition)?
return buffer "Speech recognition not supported in this browser" unless ok

$b = $ \.speakeys>.buffer
$s = $ \.speakeys>.start
$t = $ \.speakeys>.transmit

socket = io!

r = new R!
  ..onend = ->
    socket.emit \keydown, \speakeys-onend
    enable-button $s

  ..onerror = ->
    buffer "Error: #{it.error}"

  ..onresult = ->
    buffer it.results[*-1].0.transcript
    enable-button $t

  ..onstart = ->
    enable-button $s, false
    enable-button $t, false
    socket.emit \keydown, \speakeys-onstart
    buffer 'Speak now!'

var longclick-timeout
$t
  ..on \touchend ->
    clearTimeout longclick-timeout

  ..on \touchstart ->
    socket.emit \keyseq, $b.text! / ''
    longclick-timeout := setTimeout (-> socket.emit \keyseq, <[ Return ]>), 750ms
    false

$s.on \click -> r.start!

function buffer then $b.text it

function enable-button $el, enabled = true then $el.toggleClass \disabled, not enabled
