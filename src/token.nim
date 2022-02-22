import core/token
import strutils
import core/initial

type
  CoreToken = object of RootObj
    identifier*: string
    line: int
    # column: int

  AdvancedToken = object of CoreToken
    isNimSetKeys: bool
    isReversvedword: bool
    isSetKeys: bool
    isInt: bool
    isSetValKeys: bool
    isComment: bool


iterator CoreTokenize*(lines: var seq[string]): CoreToken =
  lines.add("")
  var tok: CoreToken
  for i in 0..<lines.len()-1:
    if lines[i].startsWith("#"):
      continue
    for (tokid, isSep) in lines[i].tokenize({' ', ',', '"'}):
      tok = CoreToken(identifier: tokid.strip(leading = false).strip(
          trailing = false), line: i+1)
      if tok.identifier == "":
        tok.identifier = " "
      if tok.identifier == "#":
        break
      yield tok
  lines = lines[0..lines.len()-2]

proc advancedTokenize*(coreTok: CoreToken): AdvancedToken =
  var tok: AdvancedToken = AdvancedToken(identifier: coreTok.identifier,
      line: coreTok.line, isNimSetKeys: false, isSetKeys: false,
      isInt: false, isSetValKeys: false,
      isComment: false, isReversvedword: false)
  var isInt = true
  try:
    discard coreTok.identifier.parseInt()
  except:
    isInt = false
  if coreTok.identifier in reservedWords:
    tok.isReversvedword = true
  # TODO: add setKeys and setValKeys
  # elif coreTok.identifier in setKeys:
  #   tok.isSetKeys = true
  # elif coreTok.identifier in setValKeys:
  #   tok.isSetValKeys = true
  elif coreTok.identifier in nimSetKeys:
    tok.isNimSetKeys = true
  elif isInt:
    tok.isInt = true
  return tok
