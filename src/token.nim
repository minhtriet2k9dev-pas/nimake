import core/token
import strutils
import core/initial

type
  CoreToken = object of RootObj
    identifier*: string
    line: int
    # column: int

  AdvancedToken = object of CoreToken
    isKeyword: bool
    isInt: bool
    isFloat: bool
    isComment: bool


iterator CoreTokenize*(lines: var seq[string]): CoreToken =
  lines.add("")

  var tok: CoreToken
  for i in 0..<lines.len()-1:
    for (tokid, isSep) in lines[i].tokenize({' ', ',', '"', '#'}):
      tok = CoreToken(identifier: tokid.strip(leading = false).strip(
          trailing = false), line: i)
      if tok.identifier == "":
        tok.identifier = " "
      yield tok

  lines = lines[0..lines.len()-2]


