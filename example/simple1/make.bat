@echo off
chcp 65001

set LATEX=c:/texlive/2019/bin/win32

set PYGMENTS=c:/Python36-32/Scripts
set TEXINPUTS=../../eskdi;

set TEX_SRC=simple1
set OUTPUT="simple1_.pdf"


set PATH=%LATEX%;%PYGMENTS%;%PATH%


if "%1" == "help" (
  echo "-----------------------------------------------------"
  echo "-----            Команды скрипта                -----"
  echo "-----------------------------------------------------"
  echo "-  help    - справка                                -"
  echo "-  clean   - очистка                                -"
  echo "-----------------------------------------------------"
  pause
  exit /b 0
)

if "%1" == "clean" (
  echo "-----------------------------------------------------"
  echo "-----     Выполнение очистки папки проекта      -----"
  echo "-----------------------------------------------------"
  del /s *.aux *.toc *.log *.out *eps-converted-to.pdf *.tmp *.exa *.data *.pygtex *.pygstyle *.synctex.gz >nul 2>&1
  rd /s /q  _minted-"%TEX_SRC%"    svg-inkscape >nul 2>&1
  exit /b 0
)

echo "-----------------------------------------------------"
echo "----- Проверка компонентов для сборки документа -----"
echo "-----------------------------------------------------"
echo "Предполагается, что система Win7 | Win10"

if exist %LATEX%/xelatex.exe (
  echo xelatex.exe              +
) else (
  echo ERROR: Не найден xelatex. Установите TeXLive 2018+
  pause
  exit /b 1
)

if exist %PYGMENTS%/pygmentize.exe (
  echo pygmentize.exe            +
) else (
  echo ERROR: Не найден pygmentize.
  pause
  exit /b 1
)

if exist "C:/Windows/Fonts/consola.ttf" (
  echo font: Consolas            +
) else (
  echo ERROR: Не найден шрифт Consolas.
  pause
  exit /b 1
)

if exist "C:/Windows/Fonts/times.ttf" (
  echo font: Times New Roman     +
) else (
  echo ERROR: Не найден шрифт Times New Roman.
  pause
  exit /b 1
)

timeout /t 3


xelatex.exe -synctex=1 -interaction=nonstopmode --shell-escape -8bit "%TEX_SRC%.tex"

if exist "%TEX_SRC%.pdf" (
  copy "%TEX_SRC%.pdf" "%OUTPUT%"
) else (
    echo Файл не был создан
)

pause