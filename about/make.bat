@echo off
chcp 65001

rem set LATEX=C:\texlive\2019\bin\win32\lualatex.exe
set LATEX=d:/texlive/2018/bin/win32
set PYGMENTS=c:/Python36-32/Scripts
set TEXINPUTS=../eskdi;

set TEX_SRC=about
set OUTPUT="../about.pdf"


set PATH=%LATEX%;%PYGMENTS%;%PATH%


if "%1" == "help" (
  echo "-----------------------------------------------------"
  echo "-----            Команды скрипта                -----"
  echo "-----------------------------------------------------"
  echo "-  help    - справка                                -"
  echo "-  clean   - очистка                                -"
  echo "-----------------------------------------------------"
  exit /b 0
)

if "%1" == "clean" (
  echo "-----------------------------------------------------"
  echo "-----     Выполнение очистки папки проекта      -----"
  echo "-----------------------------------------------------"
  del /s *.aux *.toc *.log *.out *eps-converted-to.pdf *.tmp *.exa *.data *.pygtex *.pygstyle *.synctex.gz >nul 2>&1
  rd /s /q _minted-top svg-inkscape >nul 2>&1
  exit /b 0
)

echo "-----------------------------------------------------"
echo "----- Проверка компонентов для сборки документа -----"
echo "-----------------------------------------------------"
echo "Предполагается, что система Win7"

if exist %LATEX%/lualatex.exe (
  echo lualatex.exe              +
) else (
  echo ERROR: Не найден lualatex. Установите TeXLive 2018+
  exit /b 1
)

if exist %PYGMENTS%/pygmentize.exe (
  echo pygmentize.exe            +
) else (
  echo ERROR: Не найден pygmentize.
  exit /b 1
)

if exist "C:/Windows/Fonts/consola.ttf" (
  echo font: Consolas            +
) else (
  echo ERROR: Не найден шрифт Consolas.
  exit /b 1
)

if exist "C:/Windows/Fonts/times.ttf" (
  echo font: Times New Roman     +
) else (
  echo ERROR: Не найден шрифт Times New Roman.
  exit /b 1
)

timeout /t 3



lualatex.exe -synctex=1 -interaction=nonstopmode --shell-escape -8bit "%TEX_SRC%.tex"
rem lualatex.exe -synctex=1 -interaction=nonstopmode --shell-escape -8bit "%TEX_SRC%.tex"

if exist "%TEX_SRC%.pdf" (
  copy "%TEX_SRC%.pdf" "%OUTPUT%"
) else (
    echo Файл не был создан
)

pause