default: output/index.html output/main.css push

output/index.html: index.md output/main.css head.html head2.html foot.html
	pandoc $< | cat head.html output/main.css head2.html - foot.html > $@

output/main.css: main.scss
	sass --style compressed main.scss output/main.css

.PHONY: push
push:
	rsync -a output/ usvs:www/nindwen.blue

.PHONY: clean
clean:
	rm output/*

