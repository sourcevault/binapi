{l} = require "./common"

reg = require "./registry"

printE = reg.printE

packageJ = reg.packageJ

reg.printE.noArg = !->

  l do
    """
    [#{packageJ.name}][argument.error] top level function did not recieve any argument.

      - to learn how to use to module you can read manual at :

        #{packageJ.homepage}

    """

reg.printE.funIsFun = !->


  l do
    """
    [#{packageJ.name}][argument.type.error] first argument should be function.

      - to learn how to use to module you can read manual at :

        #{packageJ.homepage}

    """

reg.printE.fail = (filename) -> (message) !->

  l do
    "[TEST ERROR] originating from module"
    "[#{packageJ.name}]"
    "\n\n- 'npm test' failed at #{filename}:"

  if message

    l "\n    failed at TEST NUMBER #{message}\n"


  process.exitCode = 1

module.exports = reg.printE

