import os
import strutils
import terminal
import colors

# icon constants
const defaultCfgFile = "nimakelist.nmk"
const questionIcon = "[?] "
const successIcon = "[+] "
const warningIcon = "[!] "
const errorIcon = "[x] "
const infoIcon = "[i] "
const hintIcon = "[*] "

# color constants
const questionColor = colLightPink
const successColor = colGreenYellow
const warningColor = colYellow
const errorColor = colRed
const hintColor = colLightGreen
const infoColor = colLightSkyBlue
const hlColor = colWhite

proc showMsg(colorCode: Color, icon: string = "", msg: string,
    autoIndent: bool = true, fullColor: bool = false,
        colorCodeForFullColor: Color = colorCode, indentChar: char = ' ',
            hlLine, hlStart, hlEnd: int = -1, hlMsgColorCode: Color = hlColor) =
  # def proc
  stdout.write(ansiForegroundColorCode(colorCode), icon)
  stdout.write(ansiForegroundColorCode(colorCodeForFullColor))
  var newMsg = msg.splitLines()

  proc colorHlMsgText =
    doAssert hlLine < newMsg.len()
    doAssert hlStart != -1
    doAssert hlEnd != -1
    doAssert hlStart < hlEnd
    stdout.write(newMsg[hlLine][0..hlStart-1])
    var hlMsgtext = ansiForegroundColorCode(hlMsgColorCode) & newMsg[hlLine][hlStart..hlEnd]
    stdout.styledWrite(styleItalic, hlMsgText)

    if not fullColor:
      stdout.write(ansiResetCode)
    else:
      stdout.write(ansiForegroundColorCode(colorCodeForFullColor))
    stdout.flushFile()
    echo newMsg[hlLine][hlEnd+1..^1], "."

  if not fullColor:
    stdout.write(ansiResetCode)
    stdout.flushFile()

  if hlLine == 0:
    colorHlMsgText()
  else:
    echo newMsg[0], "."

  for i in 1..<newMsg.len():
    if autoIndent:
      newMsg[i] = newMsg[i].strip(trailing = false)
    stdout.write(repeat($indentChar, icon.len()))
    if hlLine != -1 and i == hlLine:
      colorHlMsgText()
    else:
      echo newMsg[i]

  if fullColor:
    stdout.write(ansiResetCode)
    stdout.flushFile()


# platform constant
when defined(APPLE):
  const platform = "MacOS"
when defined(LINUX):
  const platform = "Linux"
when defined(WINDOWS):
  const platform = "Windows"
when defined(FREEBSD):
  const platform = "FreeBSD"
when defined(OPENBSD):
  const platform = "OpenBSD"
when defined(NETBSD):
  const platform = "NetBSD"
when defined(SOLARIS):
  const platform = "Solaris"
when defined(DARWIN):
  const platform = "Darwin"
when defined(CYGWIN):
  const platform = "Cygwin"
when defined(UNIX):
  const platform = "Unix"
else:
  const platform = "Unknown???"

# architecture constants
when defined(x86):
  const architecture = "x86"
when defined(amd64):
  const architecture = "x86-64"
when defined(amd32):
  const architecture = "x86-32"
when defined(arm):
  const architecture = "ARM"
when defined(arm64):
  const architecture = "ARM-64"
when defined(ppc):
  const architecture = "PowerPC"
when defined(ppc64):
  const architecture = "PowerPC-64"
when defined(sparc):
  const architecture = "SPARC"
when defined(sparc64):
  const architecture = "SPARC-64"
when defined(s390):
  const architecture = "S390"
when defined(s390x):
  const architecture = "S390-64"

if platform == "Windows":
  echo "Hello ", getEnv("USERNAME"), " ! :3"
elif platform == "Unix":
  echo "Hello ", getEnv("USER"), " ! :3"
else:
  echo "Hello!"

showMsg(infoColor, infoIcon, "Platform     : " & platform)
showMsg(infoColor, infoIcon, "Architecture : " & architecture)

proc getDefaultShell(): string =
  if platform == "Unix":
    var (_, name, _) = splitFile(getenv("SHELL"))
    return name;

proc detectNimakeInPath() =
  if findExe("nimake") == "":
    showMsg(warningColor, warningIcon, "Cannot find nimake in your PATH")
    showMsg(hintColor, "\t" & hintIcon, "Try to add `" & getAppDir() &
        "` to your PATH", hlLine = 0, hlStart = 12, hlEnd = getAppDir().len()+11)
    if platform == "Unix":
      showMsg(hintColor, "\t\t" & hintIcon,
          "Run this command : `echo 'export PATH=\"" & getAppDir() &
              ":$PATH\"' >> ~/." & getDefaultShell() &
                  "rc` to add nimake to your PATH", hlLine = 0, hlStart = 20,
                  hlEnd = 38 + getAppDir().len() + 15 + getDefaultShell().len() + 2)
    if platform == "Windows":
      showMsg(hintColor, "\t\t" & hintIcon,
          "Visit this link : https://bit.ly/3v4c7Cw for more infomation",
          hlLine = 0, hlStart = 18,
          hlEnd = 18 + "https://bit.ly/3v4c7Cw".len())
  else:
    showMsg(infoColor, infoIcon, "nimake was found in your PATH : `" & findExe(
        "nimake") & "`")

detectNimakeInPath()

if not fileExists(defaultCfgFile):
  showMsg(errorColor, errorIcon, "Cannot find default config file `nimakelist.nmk` in current directory")
  quit(1)

let entireFile = readFile(defaultCfgFile)
let lines = entireFile.splitLines()

