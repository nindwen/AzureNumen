#!/bin/bash

watch() {
      sass --style compressed --watch sass/:output/css
}

page() {
      markdown $1.md | cat head.html - foot.html | tidy -i -utf8 > output/$1.html
}

help() {
      echo "apuva!"
}

push() {
      rsync -a output/ usvs:www/nindwen.blue
}

if [ -z "$1" ]; then 
      echo usage: $0 [sass, watch]
      exit
fi

eval ${@}
