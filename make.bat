@echo off

set PATH=%PATH%;c:\texlive\2019\bin\win32;c:\Python36-32\Scripts
rem set PATH=c:\texlive\2019\bin\win32;c:\Python36-32\Scripts;c:\Python36-32

SET TARGET=about

xelatex  --shell-escape %TARGET%.tex
rem pause