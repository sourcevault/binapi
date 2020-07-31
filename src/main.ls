reg = require "./registry"

{com,printE} = reg

{noop,R,z,l} = com

uic = com.util-inspect-custom

require "./print" # [... load print.js ...]

# -----------------------------------------------

generic_log = (path,state) ->

  l path

  state

veri = (arglen,fun,custom_log) ->

  switch arglen
  | 0 =>
    printE.noArg!
    return null

  switch typeof fun
  | \function => 0
  | otherwise =>
    printE.type "first argument should be a function"
    return null

  switch typeof custom_log
  | \function => custom_log
  | otherwise => generic_log

# -----------------------------------------------

get = (__,key,___) ->

  switch key
  | uic       => return @log @hist,@state

  ret = @cache[key]

  if ret then return ret

  hist = @hist.concat key

  data =
    hist:hist
    cache:{}
    log:@log
    fun:@fun
    state:@state
    apply:ap
    get:get

  P = new Proxy(noop,data)

  @cache[key] = P

  return P


ap = (__,___,args) ->

  @fun @hist,args,@state


pub = (fun,state,ulog) ->

  log = veri arguments.length,fun,ulog

  switch log
  | null => return

  data =
    log:log
    fun:fun
    state:state
    hist:[]
    cache:{}
    apply:ap
    get:get

  P = new Proxy(noop,data)

  P

# ----------------------------------------------------------------------------------------

module.exports = pub