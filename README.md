# Patchnotes
A Conventional Changelog based parser for git commit messages.

## What is this?
This is a library (and maybe a tool) that parses strings in a git message format based off of Conventional Changelog. The intent is to allow for some extra flexibility in how messages are formatted and to provide a few extra features.

Essentially, this library will parse a block of text with one (or more) messages formatted like this:

```
feat(tag|Scope): Title of the message.

Body of the message.

Footer of the message with some additional #tags #here.
```

Each part is optional, aside from the `feat` and `Title of the message.`

The library / tool will parse these messages into an easy-to-utilize data format--allowing further use and/or manipulation of the data to generate changelogs automatically from git messages.

## More information
This is mostly a project to practice various forms of pattern matching and parsing (specifically in Nim.) It might also be useful for a changelog generation tool? It is **definitely not** the best way to do this parsing, and is not the fastest either. It is intended to be correct, except for perhaps some unique edge-cases. Feel free to let me know of better PEG grammars or other improvements if you happen to look at this!

This parsing library makes use of the **excellent** [npeg](https://www.github.com/zevv/npeg) PEG library by [zevv](https://www.github.com/zevv).

## Running
Tests can be run using the `nimble` and `testament` tools included with the standard Nim distribution (at least since v1.2). Easiest way to run the tests is to run `nimble test` from the project root. You can also directly run the tests contained in `tests/` using `testament`.