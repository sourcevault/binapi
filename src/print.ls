{l} = require "./common"

reg = require "./registry"

reg.printE.noArg = !->

  l do
    """
    [#{reg.packageJ.name}][argument.error] top level function did not recieve any argument.

      - to learn how to use to module you can read manual at :

        #{reg.packageJ.homepage}

    """
