const CONFIG =
  origin:[267 148]

  fingers:
    index:
      offset:[0 0]
      keys:
        * offset:[0 0]    id:\j
        * offset:[0 -100] id:\u

    middle:
      offset:[+162 -42]
      keys:
        * offset:[0 0]    id:\k
        * offset:[0 -100] id:\i

    ring:
      offset:[+244 +2]
      keys:
        * offset:[0 0]    id:\l
        * offset:[0 -100] id:\o

    pinky:
      offset:[+357 +116]
      keys:
        * offset:[0 0]    id:\;
        * offset:[0 -100] id:\p

    thumb:
      offset:[-109 +252]
      keys:
        * offset:[0 0]   id:\Space
        * offset:[100 0] id:\Return

module.exports.get-keys = ->
  keys = []
  for , f of CONFIG.fingers
    for k in f.keys
      keys.push do
        id: k.id
        x: CONFIG.origin.0 + f.offset.0 + k.offset.0
        y: CONFIG.origin.1 + f.offset.1 + k.offset.1
  keys
