return unless (R = window.webkitSpeechRecognition)?

$ \.speakeys>.unavailable .hide!
$ \.speakeys>.available .show!

$s = $ '.speakeys'
$b = $ '.speakeys .buffer'
$l = $ '.speakeys .listen'
$p = $ '.speakeys .prompt'
$t = $ '.speakeys .transmit'

var longclick-timeout
r = new R!
socket = io!

r.onend = ->
  socket.emit \keydown, \speakeys-onend
  enable-button $l
  $s.removeClass \live
r.onerror = ->
  $s.addClass \error
  text $p, "Error: #{it.error}"
r.onresult = ->
  const END-SENTENCE-RX = /[\.\?!]$/
  t = it.results[*-1].0.transcript
  t = _.capitalize t if END-SENTENCE-RX.test prev = $b.text!
  text $b, t
  enable-button $t
  $p.hide!
  $b.show!
r.onstart = ->
  $s.addClass \live .removeClass \error
  $b.hide!
  $p.show!
  enable-button $l, false
  enable-button $t, false
  socket.emit \keydown, \speakeys-onstart
  text $p, 'Google is listening!'

$l.on \click ->
  return unless $l.hasClass \enabled
  r.start!
$t.on \touchend ->
  clearTimeout longclick-timeout
$t.on \touchstart ->
  return unless $t.hasClass \enabled
  const START-PHRASE-RX = /^[\.\?!,]/
  seq = $b.text! / '' ++ [ ' ' ]
  seq.unshift \BackSpace if START-PHRASE-RX.test t = $b.text! # erase last space?
  socket.emit \keyseq, seq
  longclick-timeout := setTimeout (-> socket.emit \keyseq, <[ Return ]>), 750ms
  false

function enable-button $el, enabled = true then $el.toggleClass \enabled, enabled
function text $el, t then $el.text t
