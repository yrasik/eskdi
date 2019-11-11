SET PATH=c:\texlive\2019\bin\win32

SET TARGET=about

xelatex  --shell-escape %TARGET%.tex
rem pause