R = window.webkitSpeechRecognition

$ \.speakeys>.noscript .hide!
$ \.speakeys>.available .show! if R?
$ \.speakeys>.unavailable .show! unless R?

return unless R?

$s = $ '.speakeys'
$b = $ '.speakeys .buffer'
$l = $ '.speakeys .listen'
$p = $ '.speakeys .prompt'
$t = $ '.speakeys .transmit'

var longclick-timeout
r = new R!

r.onend = ->
  ws-send \rkeydown \speakeys-onend
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
  ws-send \rkeydown \speakeys-onstart
  text $p, 'Google is listening!'

$l.on \click ->
  return unless $l.hasClass \enabled
  r.start!
$s.on \click ->
  c = if /^[A-Z]/.test b = $b.text! then b.0.toLowerCase! else b.0.toUpperCase!
  text $b, c + b.slice 1
$t.on \touchend ->
  clearTimeout longclick-timeout
$t.on \touchstart ->
  return unless $t.hasClass \enabled
  const START-PHRASE-RX = /^[\.\?!,]/
  emit-keystroke \BackSpace if START-PHRASE-RX.test t = $b.text! # truncate previous phrase?
  ws-send \rkeydown "type:#t "
  longclick-timeout := setTimeout (-> emit-keystroke \Return), 750ms
  false

function emit-keystroke
  ws-send \rkeydown it
  ws-send \rkeyup it

function enable-button $el, enabled = true then $el.toggleClass \enabled, enabled

function text $el, t then $el.text t
