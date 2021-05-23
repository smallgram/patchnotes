# an npeg version of the message parser

import std/[strutils, tables]
import npeg


type
  PatchNote* = object
    kind*: string
    title*: string
    body*: string
    tag*: seq[string] 
    scope*: string


proc parseGitMessage*(content: string): seq[PatchNote] =
  result = @[]
  let headerParser = peg("header", d: PatchNote):
    header <- *Blank * kind * ?meta * *Blank * ':' * *Blank * title
    meta   <- '(' *
              *Blank *
              ?(>tag * *Blank * '|' * *Blank) *
              >scope *
              *Blank *
              ')':
      if capture.len > 2:
        d.tag.add($1)
        d.scope = $2 
      else:
        d.scope = $1
    kind   <- >+Alnum:
      d.kind = $1
    tag    <- *Alnum
    scope  <- +Alnum
    title  <- >+(!Cntrl * 1) * *Blank:
      d.title = $1

  let bodyParser = peg("body", d: PatchNote):
    body <- *Blank * >(?tag * *((1 - '#') * ?tag)):
      if d.body.len != 0 and d.body[^1] != '\n' and capture[0].s.strip != "":
        d.body.add ' '
      d.body.add $1
      if capture[0].s.strip == "" and d.body.len > 0:
        d.body.add '\n'
    tag <- '#' * *Blank * >*Alnum:
      d.tag.add($1)

  for line in content.splitLines:
    var p = PatchNote()
    let res = headerParser.match(line, p).ok
    if res: # found a header
      result.add(p) 
    else: # found a non-header, parse as body
      discard bodyParser.match(line, result[^1]).ok


when isMainModule:
  echo """feat(pub|Dev): This is a test.
  fix: This is another test.
  This one also has another line.
  
  Here is a 'body' part #test that
  spans multiple #test2 #test3 lines
  #test4

  of text.
  
  fix2(Dev): This is a second one.
  test(|Build): Testing.""".parseGitMessage
