# parse git logs to extract the parts
# git log settings


type
  Log* = object
    commit*: string
    author*: string
    email*: string
    date*: string
    message*: string


proc parseGitLog*(log: string): seq[Log] =
  # TODO: go through the log string and extract logs
  #       probably via a regex line-by-line, or possibly a PEG?
  echo "not implemented"
  discard