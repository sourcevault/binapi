com = require "./common"

{z,j,l,yuan,gaurd,SI} = com

{util-inspect-custom} = com

{noop,R,guard} = com

uic = util-inspect-custom

{get,printE} = require "./registry"

require "./print"

create-initial-self = (attr) ->

  out = {}

  for I in attr

    out[I] = false

  SI out


get.main = (data,key) ->

  if not data.cache[key]

    hist = switch data.type
    | \list => data.hist.concat key
    | \obj => data.hist.set key,true

    P = main do
      data.fun
      data.state
      hist
      data.type
      data.log

    data.cache[key] = P

    P

  else

    data.cache[key]


get.entry = (data,key) ->

  switch key
  | \name     => data.fun.name
  | uic       => data.log data.hist,data.state
  | otherwise => get.main data,key

ap = ({fun,hist,state},args) ->

  fun hist,args,state

handle = (data) -> @data = data;@

handle.prototype.get = (__,key,___)->  get.entry @data,key

handle.prototype.apply = (__,___,args) -> ap @data,args

handle.of = (data) -> new handle(data)

checkLog = (fun)->

  if (typeof fun.log is \function)
    return fun.log
  else if (typeof fun[uic] is \function)
    return fun[uic]
  else return -> fun.name

main = (fun,state,hist,type,log) ->

  data =
    fun:fun
    state:state
    hist:hist
    type:type
    log:log
    cache:{}

  prop = handle.of data

  P = new Proxy(noop,prop)

  P

entry = {}
  ..list = null
  ..obj = null


entry.list = (fun,state,hist = []) ->

  if (arguments.length is 0)
    printE.noArg!
    return

  if not ((typeof fun) is \function)
    printE.funIsFun!
    return

  log = checkLog fun

  main fun,state,hist,\list,log


entry.obj =(fun,state,attr = []) ->

  if (arguments.length is 0)
    printE.noArg!
    return

  if not ((typeof fun) is \function)
    printE.funIsFun!
    return

  log = checkLog fun

  hist = create-initial-self attr

  main fun,state,hist,\obj,log


# ----------------------------------------------------------------------------------------
# << INTERFACE >>

pub = entry.list

pub.list = entry.list

pub.obj = entry.obj

# ----------------------------------------------------------------------------------------

module.exports = pub