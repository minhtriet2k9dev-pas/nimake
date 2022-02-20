import coreToken
import strutils
import core

type
  CoreToken = ref object of RootObj
    identifier: string
    value: string
    line: int
    column: int

  AdvancedToken = object of CoreToken
    isKeyword: bool
    isInt: bool
    isFloat: bool


proc CoreTokenize*(lines: var seq[string]): CoreToken =
  lines.add("")

  for i in 0..<lines.len()-1:
    for (tok, isSep) in lines[i].tokenize({' ', ',', '"'}):
      echo '"', tok, '"', " - ", isSep

  lines = lines[0..lines.len()-2]
