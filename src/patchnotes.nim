import strformat

import patchnotespkg/[common, message]



when isMainModule:
  echo fmt"Patchnotes Tool v{patchnotesVersion}"
  echo fmt"Compiled at {CompileDate}: {CompileTime}"
  echo "------------------------------------"
