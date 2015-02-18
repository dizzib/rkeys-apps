ok = (R = window.webkitSpeechRecognition)?
return msg "Speech recognition not supported in this browser" unless ok

$m = $ \.speakeys>.msg
socket = io!

r = new R!
  ..onerror  = -> msg "Error: #{it.error}"
  ..onresult = -> msg it.results[*-1].0.transcript
  ..onstart  = -> msg 'Speak now!'

$ \.speakeys>.send  .on \click -> socket.emit \keyseq, $m.text! / ''
$ \.speakeys>.start .on \click -> r.start!

function msg then $m.text it