# Set global log fn. We can't just set window.log = console.log because we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

return unless (R = window.webkitSpeechRecognition)?

$ \.speakeys>.unavailable .hide!
$ \.speakeys>.available .show!

$s = $ '.speakeys'
$b = $ '.speakeys .buffer'
$l = $ '.speakeys .listen'
$p = $ '.speakeys .prompt'
$t = $ '.speakeys .transmit'

socket = io!
var longclick-timeout

r = new R!
  ..onend = ->
    socket.emit \keydown, \speakeys-onend
    enable-button $l
    $s.removeClass \live

  ..onerror = ->
    $s.addClass \error
    text $p, "Error: #{it.error}"

  ..onresult = ->
    const END-SENTENCE-RX = /[\.\?!]$/
    t = it.results[*-1].0.transcript
    t = _.capitalize t if END-SENTENCE-RX.test prev = $b.text!
    text $b, t
    enable-button $t
    $p.hide!
    $b.show!

  ..onstart = ->
    $s.addClass \live .removeClass \error
    $b.hide!
    $p.show!
    enable-button $l, false
    enable-button $t, false
    socket.emit \keydown, \speakeys-onstart
    text $p, 'Speak now!'

$l.filter \.enabled .on \click -> r.start!
$t.filter \.enabled
  ..on \touchend ->
    clearTimeout longclick-timeout
  ..on \touchstart ->
    const START-PHRASE-RX = /^[\.\?!,]/
    seq = $b.text! / '' ++ [ ' ' ]
    seq.unshift \BackSpace if START-PHRASE-RX.test t = $b.text! # erase last space?
    socket.emit \keyseq, seq
    longclick-timeout := setTimeout (-> socket.emit \keyseq, <[ Return ]>), 750ms
    false

function enable-button $el, enabled = true then $el.toggleClass \enabled, enabled
function text $el, t then $el.text t
