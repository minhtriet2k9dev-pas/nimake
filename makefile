all: format compile run 

srcFile = nimake.nim
parserFile = src/parser.nim
tokenFile = src/token.nim
coreFile = src/core/initial.nim
coreTokenFile = src/core/specialWords.nim

format:
	@nimpretty $(srcFile) $(parserFile) $(tokenFile) $(coreFile) $(coreTokenFile)

compile:
	@nim c --hints:off --outdir:bin $(srcFile)

run:
	@bin/nimake
