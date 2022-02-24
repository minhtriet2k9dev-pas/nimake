import strutils

type
  Token = object
    identifier*: string
    line*: int
    index*: int
    isInt*: bool


  # echo "Error #1 at (", tok.line, ",", tok.index, ") (", tok.line, ",",
  #     lines[i].len(), "): Undelimited string. Maybe you are missing `\"`?"
  # quit(1)


iterator myTokenize(str: string, line: int): tuple[identifier: string,
    isInt: bool, index: int] =
  var isId = false
  var isInt = false
  var isStr = false
  var retId = ""
  var st = ""
  var retIsInt = false
  var index = 0

  proc reset() =
    retId = ""
    st = ""
    retIsInt = false
    isInt = false
    isStr = false
    isId = false

  for i in 0..str.len()-1:
    let endLine = i == str.len()-1
    index = i+1

    if isStr:
      st &= str[i]

    if str[i] in Letters and not isStr:
      isId = true
      retId &= str[i]
      index += 1
    elif str[i] in Digits and not isStr:
      isInt = true
      retId &= str[i]
      index += 1
    elif str[i] == '"':
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
      yield (identifier: retId, isInt: retIsInt, index: index)
      reset()

iterator tokenize*(lines: var seq[string]): Token =
  lines.add("")
  var tok: Token
  for i in 0..<lines.len()-1:
    for (tokid, isInt, index) in lines[i].myTokenize(i+1):
      tok = Token(identifier: tokid, index: index, isInt: isInt, line: i+1)
      yield tok



