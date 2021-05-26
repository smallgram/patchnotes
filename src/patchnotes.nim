import strformat
import strutils

import cligen

import patchnotespkg/[common, message, log]


when isMainModule:
  echo fmt"Patchnotes Tool v{patchnotesVersion}"
  echo fmt"Compiled at {CompileDate}: {CompileTime}"
  echo "------------------------------------"
 
  
  # TODO: parse git log here, passing it to a log parser which will
  #       return nice data structures to work with, or right here...

  dispatch(getGitLog)
