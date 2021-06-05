# parse git logs to extract the parts
# git log settings
import osproc
import os


type
  Log* = object
    commit*: string
    author*: string
    email*: string
    date*: string
    message*: string


proc getGitLog*(path: string = "", start: string = "", finish: string = ""): string =
  ## returns a large string containing the git log of the repository at `path`
  ## with the start commit (or #tag) `start` and the end commit (or #tag)
  ## `finish`
  var projectPath = path
  if projectPath == "":
    projectPath = getCurrentDir()
  else:
    setCurrentDir(path)
    
  let rng = if start == "" and finish == "": "" else: start & ".." & finish

  let res = execCmdEx("git log --no-merges --abbrev-commit --format=medium " &
    rng, {}, nil)

  if res.exitCode == 0:
    echo res.output
    return res.output
  else:
    echo "error generating git log. is this a git repository?"
    return ""


proc parseGitLog*(log: string): seq[Log] =
  # TODO: go through the log string and extract logs
  #       probably via a regex line-by-line, or possibly a PEG?
  discard
  
