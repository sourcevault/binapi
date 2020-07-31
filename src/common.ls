# --------------------------------------------------------------------------------------

js-render     = require 'json-stringify-pretty-compact'

R             = require "ramda"

SI            = require "seamless-immutable"

# --------------------------------------------------------------------------------------

l = console.log

z = l

j = (json) !-> l js-render json

# --------------------------------------------------------

if (typeof window is "undefined") and (typeof module is "object")

  isNodeJS = true

  util = require "util"

  util-inspect-custom = util.inspect.custom


else

  util-inspect-custom = Symbol.for "nodejs.util.inspect.custom"

# --------------------------------------------------------

noop = !->

noop[util-inspect-custom] = -> @[util-inspect-custom]

main =
  j                   : j
  z                   : z
  R                   : R
  l                   : l
  SI                  : SI
  noop                : noop
  util-inspect-custom : util-inspect-custom
  isNodeJS            : isNodeJS

module.exports = main
