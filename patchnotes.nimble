# Package
mode = ScriptMode.Silent

version = "0.0.1"
author = "smallgram"
description = "A Conventional Changelog -ish patchnotes generator"
license = "MIT"
srcDir = "src"
binDir = "bin"
installExt = @["nim"]
bin = @["patchnotes"]

# Dependencies

requires "nim >= 1.4.6"
# requires "regex >= 0.19.0"
requires "cligen >= 1.5.0"
requires "npeg#e7bd87"
