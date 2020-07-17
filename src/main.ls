com = require "./common"

{z,j,l,yuan,gaurd,SI} = com

{util-inspect-custom} = com

{noop,R} = com

reg = require "./registry"

require "./print"

get = reg.get

get.main = (data,key) ->

  newpath = data.path.concat key

  main data.fun,data.state,newpath



get.entry = (data,key) ->

  uic = util-inspect-custom

  if key is "name"
    return data.fun.name
  if (key is uic)
    if data.fun.log
      return data.fun.log
    if data.fun[uic]
      return data.fun[uic]
    return noop
  else
    return get.main data,key

ap = ({fun,path,state},args) ->

  fun path,args,state

handle = (data) -> @data = data;@

handle.prototype.get = (__,key,___)->  get.entry @data,key

handle.prototype.apply = (__,___,args) -> ap @data,args

handle.of = (data) -> new handle(data)

main = reg.main

prox = (fun,state,path) ->

  data =
    fun:fun
    state:state
    path:path
    cache:{}

  prop = handle.of data

  P = new Proxy(noop,prop)

  P

main = yuan.match do
  (fun) -> prox fun,{},[]
  (fun,state) -> prox fun,state,[]
  prox
  reg.printE.noArg

F = !-> z ":mainF"

P = main F

P.hello.world

