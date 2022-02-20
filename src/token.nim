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

proc CoreTokenize*(lines: seq[string]): CoreToken =
  echo "tokenize!"
