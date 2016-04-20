default: output/index.html output/css/main.css push

output/index.html: index.md head.html head2.html foot.html
	pandoc $< | cat head.html main.css head2.html - foot.html | tidy -iq -utf8 > $@

output/css/main.css: main.scss
	sass --style compressed --update .:.

.PHONY: push
push:
	rsync -a output/ usvs:www/nindwen.blue

.PHONY: clean
clean:
	rm output/*

