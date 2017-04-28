SET PATH=c:\texlive\2014\bin\win32

SET TARGET=toy

xelatex  --shell-escape %TARGET%.tex
rem pause