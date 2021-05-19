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
requires "regex >= 0.19.0"
requires "npeg#e7bd87 "


task test, "run tests":
    let res = gorgeEx("testament --backendLogging:off p \"tests/*.nim\"")
    echo res.output
    # exec("testament --colors:off --backendLogging:off p \"tests/*.nim\"")
