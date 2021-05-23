# Package
mode = ScriptMode.Silent

version = "0.1.0"
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
requires "npeg#e7bd87"

import os 

# implement nimble-like test call, but with gorgex() for shorter errors 
task test, "run tests":
    cd(thisDir())
    for t in listFiles("tests"):
        let (dir, fn, ext) = splitFile(t)
        if fn.startsWith('t') and ext == ".nim":
            let res = gorgeEx("nim c -r " & thisDir() / t) 
            echo res.output
