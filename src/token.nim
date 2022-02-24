import strutils

type
  Token = object
    identifier*: string
    line*: int
    index*: int
    isInt*: bool


iterator myTokenize(str: string, line: int): tuple[identifier: string,
    isInt: bool, index: int] =
  var isId = false
  var isInt = false
  var isStr = false
  var retId = ""
  var st = ""
  var retIsInt = false
  var index = 0
  var isChar = false
  var i = -1

  proc reset() =
    retId = ""
    st = ""
    isChar = false
    retIsInt = false
    isInt = false
    isStr = false
    isId = false

  while i < str.len()-1:
    i += 1
    let endLine = i == str.len()-1
    index = i+1

    if isStr:
      st &= str[i]

    if isChar:
      isChar = false

    if str[i] == '\\' and isStr:
      isChar = true
      if i == str.len()-1:
        echo "Error #2 at (", line, ", ", index, "): Missing character before `\\`"
        quit(1)
      st &= str[i+1]
      i += 1

    if str[i] in Letters and not isStr and not isChar:
      isId = true
      retId &= str[i]
      index += 1
    elif str[i] in Digits and not isStr and not isChar:
      isInt = true
      retId &= str[i]
      index += 1
    elif str[i] == '"' and not isChar:
      if isStr:
        isStr = false
      else:
        isStr = true

    if (str[i] notin Letters or endLine) and isId:
      index = index - retId.len()
      yield (identifier: retId, isInt: retIsInt, index: index)
      reset()
    elif (str[i] notin Digits or endLine) and isInt:
      index = index - retId.len()
      yield (identifier: retId, isInt: retIsInt, index: index)
      reset()
    elif not isStr and st != "":
      retId = st[0..^2]
      retId = retId.replace("\\n", "\n")
      retId = retId.replace("\\t", "\t")
      retId = retId.replace("\\r", "\r")
      retId = retId.replace("\\", "")
      yield (identifier: retId, isInt: retIsInt, index: index)
      reset()

  if isStr:
    echo "Error #1 at (", line, ",", index, "): Undelimited string. Maybe you are missing `\"`?"
    quit(1)

iterator tokenize*(lines: var seq[string]): Token =
  lines.add("")
  var tok: Token
  for i in 0..<lines.len()-1:
    for (tokid, isInt, index) in lines[i].myTokenize(i+1):
      tok = Token(identifier: tokid, index: index, isInt: isInt, line: i+1)
      yield tok



