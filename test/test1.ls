reg = require "../dist/registry"

binapi = require "../dist/main"

{com,printE} = reg

{l,z,j} = com

fail = reg.printE.fail "test/test1.js"

# ------- ----------------------------------------------------------------------------------

# <| TEST 6 |>

# complex monadic api example from readme

F6 = (path,args,state) ->

  [number] = args

  switch path.length
  | 0 => binapi F6,number
  | 1 =>
    switch path[0]
    | "add" =>  binapi F6,(state + number)
    | "multiply" => binapi F6,(state*number)
    | "ret" => state
    | otherwise =>
      fail 6
  | otherwise =>
    fail 6


try

  compute = binapi F6

  out = compute 5
  .add 5
  .multiply 10
  .ret!

  if not (out is 100)

    fail 7

catch E
  l E
  fail 7


