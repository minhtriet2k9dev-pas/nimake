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


iterator myTokenize(str: string): tuple[identifier: string, isInt: bool] =
  var isId = false
  var isInt = false
  var isStr = false
  var retId = ""
  var retIsInt = false

  proc reset() =
    retId = ""
    retIsInt = false
    isInt = false
    isStr = false
    isId = false

  for i in 0..str.len()-1:
    let endLine = i == str.len()-1
    if str[i] in Letters:
      isId = true
      retId &= str[i]
    if (str[i] notin Letters or endLine) and isId:
      isId = false
      yield (identifier: retId, isInt: retIsInt)
      reset()

iterator tokenize*(lines: var seq[string]): Token =
  lines.add("")
  var tok: Token
  for i in 0..<lines.len()-1:
    var index = 1
    for (tokid, isInt) in lines[i].myTokenize():
      tok = Token(identifier: tokid.strip(leading = false).strip(
          trailing = false), line: i+1, index: index, isInt: isInt)
      echo tokid
      index += tokid.len()
      yield tok



