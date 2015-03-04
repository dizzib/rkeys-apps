const CONFIG =
  origin:[240 180]

  fingers:
    index-l:
      offset:[-80 +10]
      keys:
        * offset:[-10 -140] id:\6
        * offset:[0 -70] id:\y
        * offset:[0 0] id:\h
        * offset:[20 +80] id:\n

    index:
      offset:[+20 0]
      keys:
        * offset:[0 -140] id:\7
        * offset:[-10 -70] id:\u
        * offset:[0 0]    id:\j
        * offset:[20 +80] id:\m

    middle:
      offset:[+140 -42]
      keys:
        * offset:[-20 -120] id:\8
        * offset:[-20 -60] id:\i
        * offset:[0 0]    id:\k
        * offset:[-10 +70] id:\,

    ring:
      offset:[+244 +2]
      keys:
        * offset:[0 -140] id:\9
        * offset:[0 -60] id:\o
        * offset:[0 0]    id:\l
        * offset:[-10 +70] id:\.

    pinky:
      offset:[+357 +100]
      keys:
        * offset:[0 -190] id:\0
        * offset:[0 -90] id:\p
        * offset:[0 0]   id:\;
        * offset:[-20 +70] id:\/

    pinky-r:
      offset:[+460 +116]
      keys:
        * offset:[0 -120] id:\BackSpace
        #* offset:[0 -60] id:\[
        #* offset:[0 0]   id:\'
        * offset:[0 0] id:\Shift_R
        #* offset:[-20 +50] id:\Shift_R

    thumb:
      offset:[-100 +220]
      keys:
        * offset:[0 0]   id:\space
        * offset:[250 0] id:\Return

module.exports.get-keys = ->
  keys = []
  for , f of CONFIG.fingers
    for k in f.keys
      keys.push do
        id: k.id
        x: CONFIG.origin.0 + f.offset.0 + k.offset.0
        y: CONFIG.origin.1 + f.offset.1 + k.offset.1
  keys
