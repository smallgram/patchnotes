import strformat
import strutils
import os
import strformat

# import cligen

import patchnotespkg/[common, message, gitlog]


when isMainModule:
  echo fmt"Patchnotes Tool v{patchnotesVersion}"
  echo fmt"Compiled at {CompileDate}: {CompileTime}"
  echo "------------------------------------"
 
  
  # TODO: parse git log here, passing it to a log parser which will
  #       return nice data structures to work with, or right here...
  
  for log in getCurrentDir().getGitLog().parseGitLog():
    echo fmt"""
    {log.commit   = }
    {log.author   = }
    {log.email    = }
    {log.date     = }
    {log.message  = }
    """.unindent


  # can use `dispatch` to create a CLI essentially
  # dispatch(getGitLog)
