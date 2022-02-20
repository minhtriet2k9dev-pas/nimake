import os
import strutils
import core
import token

proc setup() =
  showMsg(infoColor, infoIcon, "Platform     : " & platform)
  showMsg(infoColor, infoIcon, "Architecture : " & architecture)
  helloUser()
  detectNimakeInPath()

  if not fileExists(defaultCfgFile):
    showMsg(errorColor, errorIcon, "Cannot find default config file `nimakelist.nmk` in current directory")
    quit(1)

setup()

let entireFile = readFile(defaultCfgFile)
let lines = entireFile.splitLines()

discard CoreTokenize(lines)
