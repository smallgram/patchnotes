# parse git logs to extract the parts
# git log settings
import osproc
import os
import strutils
import message
import json
import std/jsonutils


type
  Log* = object
    commit*: string
    author*: string
    email*: string
    date*: string
    message*: string
    patchnote*: PatchNote


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
    # echo res.output
    return res.output
  else:
    raise newException(IOError, "Error generating git log. Is this a git " &
                                "repository?")


iterator parseGitLog*(log: string): Log =
  var res = Log()
  for line in log.splitLines:
    # echo "line: " & line
    # echo "line length: " & $line.len
    if line.startswith("commit"):
      if res.commit != "":
        res.message = res.message.dedent
        let pn = res.message.parseGitMessage()
        if pn.len > 0:
          res.patchnote = res.message.parseGitMessage()[0]
        else:
          res.patchnote = PatchNote()
        yield res
        res = Log()
      let commit = line.split(" ")[1]
      res.commit = commit 
    else:
      if res.commit != "":
        if line.startswith("Author:"):
          let author = line.split(" ")[1]
          let email = line.split(" ")[2]
          res.author = author
          res.email = email
        elif line.startswith("Date:"):
          let date = line.split(":", 1)[1]
          res.date = date.strip
        elif line.startswith("    ") or line.len == 0: 
          res.message.add line & '\n'
        else:
          echo "unrecognized line: " & line
      else:
        echo "unrecognized line: " & line

# convert a Log to a Json node
proc logToJson*(log: Log): JsonNode =
  result = %*
    {
      "commit": log.commit,
      "author": log.author,
      "email": log.email,
      "date": log.date,
      "message": log.message,
      "title": log.patchnote.title,
      "body": log.patchnote.body,
      "tag": log.patchnote.tag,
      "scope": log.patchnote.scope,
      "kind": log.patchnote.kind
    }