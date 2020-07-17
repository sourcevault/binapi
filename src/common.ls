# --------------------------------------------------------------------------------------

js-render     = require 'json-stringify-pretty-compact'

R             = require "ramda"

guard         = require "guard-js"

yuan          = require \@yuanchuan/match

SI            = require "seamless-immutable"

reg           = require "./registry"

# --------------------------------------------------------------------------------------

l = console.log

z = l

noop = !->

j = (json) !-> l js-render json

# --------------------------------------------------------

if (typeof window is "undefined") and (typeof module is "object")

  isNodeJS = true

  util = require "util"

  util-inspect-custom = util.inspect.custom

else

  util-inspect-custom = Symbol.for "nodejs.util.inspect.custom"

# --------------------------------------------------------


main =
  j                   : j
  z                   : z
  R                   : R
  l                   : l
  SI                  : SI
  guard               : guard
  yuan                : yuan
  noop                : noop
  util-inspect-custom : util-inspect-custom
  isNodeJS            : isNodeJS

module.exports = main
