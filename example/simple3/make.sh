#! /bin/bash

#LATEX='/usr/local/texlive/2018/bin/x86_64-linux/xelatex'
LATEX='/usr/local/texlive/2022/bin/x86_64-linux/xelatex'

export TEXINPUTS=.:$(pwd)/../../eskdi//:$TEXINPUTS

TEX_SRC='toy'
OUTPUT='toy_.pdf'


if [ "$1" = "help" ]; then
  echo '-----------------------------------------------------'
  echo '-----            Команды скрипта                -----'
  echo '-----------------------------------------------------'
  echo '-  help    - справка                                -'
  echo '-  clean   - очистка                                -'
  echo '-----------------------------------------------------'
  exit 0
elif [ "$1" = "clean" ]; then
  echo '-----------------------------------------------------'
  echo '-----     Выполнение очистки папки проекта      -----'
  echo '-----------------------------------------------------'
  find . -type f -name "*.aux" -exec rm -f {} \;
  find . -type f -name "*.toc" -exec rm -f {} \;
  find . -type f -name "*.log" -exec rm -f {} \;
  find . -type f -name "*.out" -exec rm -f {} \;
  find . -type f -name "*eps-converted-to.pdf" -exec rm -f {} \;
  find . -type f -name "*.tmp" -exec rm -f {} \;
  find . -type f -name "*.exa" -exec rm -f {} \;
  find . -type f -name "*.data" -exec rm -f {} \;
  find . -type f -name "*.pygtex" -exec rm -f {} \;
  find . -type f -name "*.pygstyle" -exec rm -f {} \;
  find . -type f -name "*.synctex.gz" -exec rm -f {} \;
  find . -type d -name "_minted-*" -exec rm -rf {} \;
  find . -type d -name "svg-inkscape" -exec rm -rf {} \;
  exit 0
fi


echo '-----------------------------------------------------'
echo '----- Проверка компонентов для сборки документа -----'
echo '-----------------------------------------------------'
echo 'Предполагается, что система Ubuntu 2018+'

if [ -e "${LATEX}" ]; then
  echo 'xelatex                   +'
else
  echo 'ERROR: Не найден xelatex. Установите TeXLive 2018+'
  exit 1
fi

if [ -e '/usr/bin/pygmentize' ] || [ -e '/usr/local/bin/pygmentize' ]; then
  echo 'pygmentize                +'
else
  echo 'ERROR: Не найден pygmentize.'
  exit 1
fi

if [ -e "/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman.ttf" ]; then
  echo 'font: Times New Roman     +'
else
  echo 'ERROR: Не найден шрифт Times New Roman.'
  exit 1
fi

if [ -e "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf" ]; then
  echo 'font: Arial               +'
else
  echo 'ERROR: Не найден шрифт Arial.'
  exit 1
fi

if [ -e "/usr/share/fonts/truetype/Consolas/consolas.ttf" ]; then
  echo 'font: Consolas            +'
else
  echo 'ERROR: Не найден шрифт Consolas.'
  exit 1
fi


${LATEX} -synctex=1 -interaction=nonstopmode --shell-escape -8bit "${TEX_SRC}.tex"

if [ -f "${TEX_SRC}.pdf" ]; then
  cp "${TEX_SRC}.pdf"  "${OUTPUT}"
else
  echo 'Файл не был создан'
fi
