com = require "../dist/common"

{l,z} = com

binapi = require "../dist/main"

reg = require "../dist/registry"

fail = reg.printE.fail "test/test1.js"

# ------- ----------------------------------------------------------------------------------

# <| TEST 7 |>

# complex monadic api example from readme

F7 = (path,args,state) ->

  [number] = args

  switch path.length
  | 0 => binapi.list F7,number
  | 1 =>
    switch path[0]
    | "add" =>  binapi.list F7,(state + number)
    | "multiply" => binapi.list F7,(state*number)
    | "ret" => state
    | otherwise =>
      fail 7
  | otherwise =>
    fail 7


try

  compute = binapi.list F7

  out = compute 5
  .add 5
  .multiply 10
  .ret!

  if not (out is 100)

    fail 7

catch E
  l E
  fail 7


