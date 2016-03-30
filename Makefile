
%.html: %.md head.html foot.html
	markdown $< | cat head.html - foot.html | tidy -iq -utf8 > output/$@

css: sass/main.scss
	sass --style compressed --update sass:output/css

all: index.html css

push: all
	rsync -a output/ usvs:www/nindwen.blue
