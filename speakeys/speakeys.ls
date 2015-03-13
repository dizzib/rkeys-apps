$b = $ \.speakeys>.buffer
$p = $ \.speakeys>.prompt
$s = $ \.speakeys>.start
$t = $ \.speakeys>.transmit

ok = (R = window.webkitSpeechRecognition)?
return text $p, "Speech recognition not supported in this browser" unless ok

socket = io!

r = new R!
  ..onend = ->
    socket.emit \keydown, \speakeys-onend
    enable-button $s

  ..onerror = ->
    text $p, "Error: #{it.error}"

  ..onresult = ->
    text $b, it.results[*-1].0.transcript
    $p.hide!
    $b.show!
    enable-button $t

  ..onstart = ->
    $b.hide!
    $p.show!
    enable-button $s, false
    enable-button $t, false
    socket.emit \keydown, \speakeys-onstart
    text $p, 'Speak now!'

var longclick-timeout
$t
  ..on \touchend ->
    clearTimeout longclick-timeout
  ..on \touchstart ->
    socket.emit \keyseq, $b.text! / ''
    longclick-timeout := setTimeout (-> socket.emit \keyseq, <[ Return ]>), 750ms
    false

$s.on \click -> r.start!

function enable-button $el, enabled = true then $el.toggleClass \disabled, not enabled
function text $el, t then $el.text t
