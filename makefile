all: format compile run

srcFile = src/nimake.nim

format:
	@nimpretty $(srcFile)

compile:
	@nim c --hints:off -o:bin/nimake $(srcFile)
run:
	@bin/nimake