SET PATH=c:\texlive\2014\bin\win32

SET TARGET=about

xelatex  --shell-escape %TARGET%.tex
rem pause