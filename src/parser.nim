import token
import core/initial

proc parseFile*() =
  var lastLine = 0
  for tok in fileLines.tokenize():
    echo tok
