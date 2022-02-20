for_unix: format compile_unix run_unix
for_win: format compile_win run_win
win_on_unix: format compile_win_on_unix
unix_dev: compile_win_on_unix for_unix

srcFile = src/nimake.nim
parserFile = src/parser.nim
tokenFile = src/token.nim
coreFile = src/core.nim
coreTokenFile = src/coreToken.nim

format:
	@nimpretty $(srcFile) $(libFile) $(tokenFile) $(coreFile) $(coreTokenFile)

compile_unix:
	@nim c --hints:off -o:bin/nimake $(srcFile)

run_unix:
	@bin/nimake

compile_win: 
	@nim c --hints:off -o:bin/nimake.exe $(srcFile)

run_win:
	@bin/nimake.exe


compile_win_on_unix: 
	@nim c --hints:off --d:mingw -o:bin/nimake.exe $(srcFile)