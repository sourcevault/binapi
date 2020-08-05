reg = require "../dist/registry"

binapi = require "../dist/main"

{com,printE} = reg

{l,z} = com

fail = reg.printE.fail "test/test2.js"

# ------------------------------------------------------------------------------------------

main = ->

getter = (state,key) ->
	state.concat key

log = (state) ->

	chain = state.join(' | ')

	"( " + chain + " )"

test = binapi(main,getter,[],log)

tsf = test.sync.flip




