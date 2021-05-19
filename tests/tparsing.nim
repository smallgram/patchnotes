discard """
  timeout: 5
  cmd: "nim c --stacktrace:off $file"
"""

import strutils
import sugar
import sequtils
import patchnotespkg/message


let sampleMessage = unindent """
  feat: Added some feature.

  Here is a message body for the feature.
  It has multiple lines.

  fix: Did something with no scope or tags. 

  This is the fix's body. This would be purely for git.

  chore(Dev): Changed something boring in the Dev tools.
  docs(Build): Documented something in the build system
  and then here's stuff on another line.

  fix(|Dev): This is another test with a weird scope.

  fix(pub|Dev): Fixed something that was broken.
  I have a second line on this message.

  And here is the fix's body.

  Here is a footer with some keywords in it:
  Closes #100. Thanks to @someguy.

  feat(pub|Profile): Did a new feature with the Profile
  that we want to get reported. BREAKING. There are some additional
  tags below.
  #dev #private."""


let parsed = parseGitMessage(sampleMessage)

let
  correctTypes = @["feat", "fix", "chore", "docs", "fix", "fix", "feat"]
  parsedTypes = parsed.map((p) => p.kind)

assert parsedTypes == correctTypes, "Types parsing error."

let
  correctBody = @[
    "Here is a message body for the feature. It has multiple lines.\n",
    "This is the fix\'s body. This would be purely for git.\n",
    "",
    "and then here's stuff on another line.\n",
    "",
    "I have a second line on this message.\nAnd here is the fix's body.\n" &
    "Here is a footer with some keywords in it: Closes #100. " &
    "Thanks to @someguy.\n", 
    "that we want to get reported. BREAKING. There are some additional tags " &
    "below. #dev #private."]
  parsedBody = parsed.map((p) => p.body)

if correctBody != parsedBody: 
  echo correctBody
  echo parsedBody

assert parsedBody == correctBody, "Body parsing error."

let
  correctTags = @[@[], @[], @[], @[], @[""], @["pub", "100"], @["pub", "dev", "private"]]
  parsedTags = parsed.map((p) => p.tag)

assert parsedTags == correctTags, "Tags parsing error."

let
  correctScopes = @["", "", "Dev", "Build", "Dev", "Dev", "Profile"]
  parsedScopes = parsed.map((p) => p.scope)

assert parsedScopes == correctScopes, "Scopes parsing error."