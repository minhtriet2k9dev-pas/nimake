import os
import strutils
import core/initial
import token

proc setup() =
  # helloUser()
  showMsg(infoColor, infoIcon, "Platform     : " & platform, hlLine = 0,
      hlStart = 14, hlEnd = 14+platform.len())
  showMsg(infoColor, infoIcon, "Architecture : " & architecture, hlLine = 0,
      hlStart = 14, hlEnd = 14+architecture.len())
  detectNimakeInPath()

  if not fileExists(defaultCfgFile):
    showMsg(errorColor, errorIcon, "Cannot find default config file `nimakelist.nmk` in current directory")
    quit(1)

# setup()

let entireFile = readFile(defaultCfgFile)
var lines = entireFile.splitLines()

for tok in lines.CoreTokenize():
  echo advancedTokenize(tok)
