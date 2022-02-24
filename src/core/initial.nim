from os import fileExists
from strutils import splitLines

const defaultCfgFile* = "nimakelist.nmk"
var isError* = false


proc setup*() =
  if not fileExists(defaultCfgFile):
    echo "Cannot find default config file `nimakelist.nmk` in current directory"
    quit(1)

const entireFile* = readFile(defaultCfgFile)
var fileLines* = entireFile.splitLines()

# import terminal
# import colors

# # icon constants
# const questionIcon* = "[?] "
# const successIcon* = "[+] "
# const warningIcon* = "[!] "
# const errorIcon* = "[x] "
# const infoIcon* = "[i] "
# const hintIcon* = "[*] "

# # color constants
# const questionColor* = colLightPink
# const successColor* = colGreenYellow
# const warningColor* = colYellow
# const errorColor* = colRed
# const hintColor* = colLightGreen
# const infoColor* = colLightSkyBlue
# const hlColor* = colPink


# proc showMsg*(colorCode: Color, icon: string = "", msg: string,
#     autoIndent: bool = true, fullColor: bool = false,
#         colorCodeForFullColor: Color = colorCode, indentChar: char = ' ',
#             hlLine, hlStart, hlEnd: int = -1, hlMsgColorCode: Color = hlColor,
#                 isItalic: bool = false) =
#   # def proc
#   stdout.write(ansiForegroundColorCode(colorCode), icon)
#   stdout.write(ansiForegroundColorCode(colorCodeForFullColor))
#   var newMsg = msg.splitLines()

#   proc colorHlMsgText =
#     doAssert hlLine < newMsg.len()
#     doAssert hlStart != -1
#     doAssert hlEnd != -1
#     doAssert hlStart < hlEnd
#     stdout.write(newMsg[hlLine][0..hlStart-1])
#     var hlMsgtext = ansiForegroundColorCode(hlMsgColorCode) & newMsg[hlLine][hlStart..hlEnd]
#     if isItalic:
#       stdout.styledWrite(styleItalic, hlMsgText)
#     else:
#       stdout.write(hlMsgText)

#     if not fullColor:
#       stdout.write(ansiResetCode)
#     else:
#       stdout.write(ansiForegroundColorCode(colorCodeForFullColor))
#     stdout.flushFile()
#     echo newMsg[hlLine][hlEnd+1..^1]

#   if not fullColor:
#     stdout.write(ansiResetCode)
#     stdout.flushFile()

#   if hlLine == 0:
#     colorHlMsgText()
#   else:
#     echo newMsg[0]

#   for i in 1..<newMsg.len():
#     if autoIndent:
#       newMsg[i] = newMsg[i].strip(trailing = false)
#     stdout.write(repeat($indentChar, icon.len()))
#     if hlLine != -1 and i == hlLine:
#       colorHlMsgText()
#     else:
#       echo newMsg[i]

#   if fullColor:
#     stdout.write(ansiResetCode)
#     stdout.flushFile()

# proc showErrorMsg*(msg: string) =
#   isError = true
#   showMsg(errorColor, errorIcon, msg)

# proc showWarningMsg*(msg: string) =
#   showMsg(warningColor, warningIcon, msg)

# proc showSuccessMsg*(msg: string) =
#   showMsg(successColor, successIcon, msg)

# proc showQuestionMsg*(msg: string) =
#   showMsg(questionColor, questionIcon, msg)

# proc showHintMsg*(msg: string) =
#   showMsg(hintColor, hintIcon, msg)

# proc showInfoMsg*(msg: string) =
#   showMsg(infoColor, infoIcon, msg)
