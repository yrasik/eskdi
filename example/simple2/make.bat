@echo off

set PATH=%PATH%;c:\texlive\2016\bin\win32;c:\Python27\Scripts

rem echo %PATH%
rem pause

SET TARGET=simple2

xelatex  --shell-escape %TARGET%.tex
rem pause