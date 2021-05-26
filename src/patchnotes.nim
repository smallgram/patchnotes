import strformat
import strutils

import cligen

import patchnotespkg/[common, message, log]


when isMainModule:
  echo fmt"Patchnotes Tool v{patchnotesVersion}"
  echo fmt"Compiled at {CompileDate}: {CompileTime}"
  echo "------------------------------------"

  # TODO: take in command line options:
  #       path: path string, if blank, use CWD
  #       start: commit or tag string, if blank, use earliest commit
  #       end: commit or tag string, if blank, use most recent commit

  
  
  

  # TODO: parse git log here, passing it to a log parser which will
  #       return nice data structures to work with, or right here...

  dispatch(getGitLog)
