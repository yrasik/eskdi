#! /bin/bash
# Скрипт предназначен для переконвертации папок с фотографиями
# На выходе папка с таким же названием, но содержащая фотографии 800х600
# и с подписанной в правом нижнем углу датой создания (это рулит в фоторамках).
# Этот скрипт использует пакет ImageMagic, юзается из cygwin, но можно 
# из под Linux с соответствущим исправлением путей....

ORIGINAL_NAME_DIR="2014_from_01_to_01"


IMAGEMAGIC_DIR="/cygdrive/e/Program Files/ImageMagick-6.8.8-Q16"

#SOURCE_TOP_DIR="/cygdrive/e"
#SOURCE_DIR=$SOURCE_TOP_DIR/"1"

SOURCE_TOP_DIR="/cygdrive/z"
SOURCE_DIR=$SOURCE_TOP_DIR/$ORIGINAL_NAME_DIR

TARGET_TOP_DIR="/cygdrive/e/2"
TARGET_DIR=$TARGET_TOP_DIR/$ORIGINAL_NAME_DIR


export PATH+=$IMAGEMAGIC_DIR


#В файл список доступных шрифтов
#convert -list font>fonts.txt


if [ -d $TARGET_DIR ];
then

 filecount=`find $TARGET_DIR -type f | wc -l`

 if [ $filecount != 0 ];
 then
  echo "Директория не пустая !!"
  exit 0
 fi

else
  mkdir $TARGET_DIR

fi

cd $SOURCE_DIR

filecount_max=`find . -type f -name '*.JPG' -o -name '*.jpg' | wc -l`
let count=0
let filecount_percent=0

find  . -name '*.JPG' -o -name '*.jpg' | while read image_file;

do

DATETIMEORIGINAL=`identify -format %[exif:DateTimeOriginal] $SOURCE_DIR/$image_file`

convert $SOURCE_DIR/$image_file -resize 800x600 \
-region 120x23+680+575 -fill white -colorize 35% \
-region 800x600+0+0 \
-fill black -font Helvetica-Bold -pointsize 23 \
-draw "text 680,595 \"$DATETIMEORIGINAL\"" \
$TARGET_DIR/$image_file

let count=count+1
let filecount_percent=100*$count/$filecount_max

echo -ne 'Прогресс: ('$filecount_percent'%)   \r'

done

echo -e "\a"

