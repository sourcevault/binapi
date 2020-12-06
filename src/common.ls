# --------------------------------------------------------------------------------------

R             = require "ramda"

# --------------------------------------------------------------------------------------

l = console.log

z = l

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
  z                   : z
  R                   : R
  l                   : l
  noop                : noop
  util-inspect-custom : util-inspect-custom
  isNodeJS            : isNodeJS

module.exports = main
