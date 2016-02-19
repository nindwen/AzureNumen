#!/bin/bash

style() {
      sass --style compressed --update sass:output/css
}

watch() {
      sass --style compressed --watch sass/:output/css
}

page() {
      markdown $1.md | cat head.html - foot.html | tidy -iq -utf8 > output/$1.html
}

help() {
      echo "apuva!"
}

build() {
      style
      page index
}

push() {
      build
      rsync -a output/ usvs:www/nindwen.blue
}

if [ -z "$1" ]; then 
      push
      exit
fi

eval ${@}
