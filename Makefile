SRC_NOTES := $(wildcard notes/*.md)
OUT_NOTES := $(patsubst notes/%.md,output/notes/%.html,$(SRC_NOTES))

default: push

output/index.html: index.md output/main.css template/head.html template/head2.html template/foot.html
	pandoc $< | cat template/head.html output/main.css template/head2.html - template/foot.html > $@

output/%.css: style/%.scss
	sass --sourcemap=none --style compressed $< $@

output/notes/%.html: notes/%.md output/notes.css 
	pandoc --highlight-style=breezedark --template=template/notes-template.html $< > $@

.PHONY: notes
notes: $(OUT_NOTES) output/notes.css template/head.html template/head3.html template/foot.html
	ruby build_index.rb | cat template/head.html output/notes.css template/head3.html - template/foot.html > output/notes/index.html

.PHONY: push
push: output/index.html notes
	rsync -a output/ usvs:www/nindwen.blue

.PHONY: clean
clean:
	rm output/*
	rm output/notes/*

.PHONY: ipfs-publish
ipfs-publish: push
	ssh usvs 'ipfs name publish /ipfs/$$(ipfs add -Qw www/nindwen.blue/{index.html,persikka.png,66006f.png})'
