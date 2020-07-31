
reg = require "../dist/registry"

binapi = require "../dist/main"

{com,printE} = reg

{l,z,j} = com

fail = reg.printE.fail "test/test2.js"

# ------- ----------------------------------------------------------------------------------

# <| TEST 1 |>

P = binapi do
  (path) ->

    ret = {}

    for I in path

      ret[I] = true

    ret

K = P.flip.callback!



if not (K.flip or K.callback)

  fail 1

# <| TEST 2 to 4 |>

subtract = (flags,args) ->

  [a,b] = args

  if flags.includes \flip # flip arguments

    temporary = a

    a = b

    b = temporary

  output = a - b

  if flags.includes \abs # output only absolute value

    return Math.abs output

  return output


sub  = binapi subtract

# <| TEST 2 |>

if not ((sub 10,5) is 5)

  fail 2

# <| TEST 3 |>

if not ((sub.flip.subtract 10,5 ) is -5)

  fail 3

# <| TEST 4 |>

if not ((sub.flip.abs 10,5) is 5)

  fail 4