import os
import strutils
import core/initial
import token

proc setup() =
  # helloUser()
  showMsg(infoColor, infoIcon, "Platform     : " & platform)
  showMsg(infoColor, infoIcon, "Architecture : " & architecture)
  detectNimakeInPath()

  if not fileExists(defaultCfgFile):
    showMsg(errorColor, errorIcon, "Cannot find default config file `nimakelist.nmk` in current directory")
    quit(1)

setup()

let entireFile = readFile(defaultCfgFile)
var lines = entireFile.splitLines()

for tok in CoreTokenize(lines):
  echo '"', tok.identifier, '"'
