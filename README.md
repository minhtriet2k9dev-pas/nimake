# nimake

## Why Nimake?

Nimake is similar to cmake but easier to use and render less files
Nimake will render makefile and allow you to create your rule and also multiple compile for many files
Also with some trick you can use nimake as build system for other languages

## Running

### Unix

    make for_unix

### Windows

    make for_win

### Building for Windows on Unix ( ! Require mingw)

    make win_on_unix

### Building for Windows on Unix and run Unix executable file ( ! Require mingw)

    make unix_dev

## Requirements

1. Nim >= 1.6.4
2. Nimbke >= 0.13.1
3. Make
4. Your brain ofcourse:)

## Docs (files)

-   `docs/syntax/reservewords.md` : nimake standard reserve word
