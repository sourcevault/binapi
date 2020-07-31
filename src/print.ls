reg = require "./registry"

l = reg.com.l

printE = reg.printE

packageJ = reg.packageJ

printE.noArg = !->

  l do
    """
    [#{packageJ.name}][argument.error] top level function did not recieve any argument.

      - to learn how to use to module you can read manual at :

        #{packageJ.homepage}

    """

printE.type = (message)->


  l do
    """
    [#{packageJ.name}][argument.type.error] #{message}.

      - to learn how to use to module you can read manual at :

        #{packageJ.homepage}

    """

printE.fail = (filename) -> (message) !->

  l do
    "[TEST ERROR] originating from module"
    "[#{packageJ.name}]"
    "\n\n- 'npm test' failed at #{filename}:"

  if message

    l "\n    failed at TEST NUMBER #{message}\n"


  process.exitCode = 1

