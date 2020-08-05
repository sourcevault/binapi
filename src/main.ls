reg = require "./registry"

{com,printE} = reg

{noop,R,z,l} = com

uic = com.util-inspect-custom

require "./print" # [... load print.js ...]

# -----------------------------------------------

generic_log = (state) ->

  state

veri = (arglen,fun,uget,state,ulog) ->

  switch arglen
  | 0 =>
    printE.noArg!
    return null

  switch typeof fun
  | \function => 0
  | otherwise =>
    printE.type "first argument should be a function"
    return null

  switch typeof uget
  | \function => 0
  | otherwise =>
    printE.type "second argument ( getter) should be a function"
    return null

  switch typeof ulog
  | \function => ulog
  | otherwise => generic_log

# -----------------------------------------------

ap = (__,___,args) ->

  @fun @state,args

get = (__,ukey,___) ->

  switch ukey
  | uic       => return @log @state

  ret = @cache[ukey]

  if ret then return ret

  state = @uget @state,ukey

  data =
    cache:{}
    log:@log
    fun:@fun
    state:state
    apply:ap
    get:get
    uget:@uget

  P = new Proxy(noop,data)

  @cache[ukey] = P

  return P

pub = (fun,uget,state,ulog) ->

  log = veri arguments.length,fun,uget,state,ulog

  switch log
  | null => return

  data =
    log:log
    fun:fun
    state:state
    uget:uget
    cache:{}
    apply:ap
    get:get

  P = new Proxy(noop,data)

  P

# ----------------------------------------------------------------------------------------

module.exports = pub