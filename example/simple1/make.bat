SET PATH=c:\texlive\2014\bin\win32

SET TARGET=simple1

xelatex  --shell-escape %TARGET%.tex
rem pause