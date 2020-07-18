
com = require "../dist/common"

{l,z} = com

binapi = require "../dist/main"

util = require 'util'

reg = require "../dist/registry"

fail = reg.printE.fail "test/test.js"

uic = util.inspect.custom

# ------- ----------------------------------------------------------------------------------

Empty = (obs)-> obs

Empty1 = (obs)-> obs

Empty1[uic] = -> @

# <| TEST 1 |>

P = binapi.obj Empty

K = P.flip.callback!


if not (K.flip or K.callback)

  fail 1

# <| TEST 2 |>

prox-list = binapi.list Empty

list = prox-list.flip.callback!

if not ((list[0] is 'flip') or (list[1] is 'callback'))

  fail 2


# <| TEST 3 to 5 |>

subtract = (flags,args) ->

  [a,b] = args

  if flags.flip # flip arguments

    temporary = a

    a = b

    b = temporary

  output = a - b

  if flags.abs # output only absolute value

    return Math.abs output

  return output


sub  = binapi.obj subtract

# <| TEST 3 |>

if not ((sub 10,5) is 5)

  fail 4

# <| TEST 5 |>

if not ((sub.flip.subtract 10,5 ) is -5)

  fail 5

# <| TEST 6 |>

if not ((sub.flip.abs 10,5) is 5)

  fail 6