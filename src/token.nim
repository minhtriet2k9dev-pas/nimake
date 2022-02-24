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
  var retIsInt = false
  var line = 1
  var index = 1

  proc reset() =
    retId = ""
    retIsInt = false
    isInt = false
    isStr = false
    isId = false

  for i in 0..str.len()-1:
    let endLine = i == str.len()-1
    index = i+1

    if isStr: 
      retId &= str[i]

    if str[i] in Letters:
      isId = true
      retId &= str[i]
      index += 1
    elif str[i] in Digits:
      isInt = true
      retId &= str[i]
      index += 1
    elif str[i] == '"':
      if isStr:
        isStr = false
      else:
        isStr = true

    if (str[i] notin Letters or endLine) and isId:
      isId = false
      index = index - retId.len()
      yield (identifier: retId, isInt: retIsInt, index: index)
      reset()
    elif (str[i] notin Digits or endLine) and isInt:
      isInt = false
      retIsInt = true
      index = index - retId.len()
      yield (identifier: retId, isInt: retIsInt, index: index)
      reset()

iterator tokenize*(lines: var seq[string]): Token =
  lines.add("")
  var tok: Token
  for i in 0..<lines.len()-1:
    for (tokid, isInt, index) in lines[i].myTokenize(i+1):
      tok = Token(identifier: tokid.strip(leading = false).strip(
          trailing = false), index: index, isInt: isInt, line: i+1)
      yield tok



