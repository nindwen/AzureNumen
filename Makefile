SRC_NOTES := $(wildcard notes/*.md)
OUT_NOTES := $(patsubst notes/%.md,output/notes/%.html,$(SRC_NOTES))

default: push

output/index.html: index.md output/main.css head.html head2.html foot.html
	pandoc $< | cat head.html output/main.css head2.html - foot.html > $@

output/%.css: %.scss
	sass --sourcemap=none --style compressed $< $@

output/notes/%.html: notes/%.md output/notes.css 
	pandoc --highlight-style=breezedark --template=notes-template.html $< > $@

.PHONY: notes
notes: $(OUT_NOTES) output/notes.css head.html head3.html foot.html
	ruby build_index.rb | cat head.html output/notes.css head3.html - foot.html > output/notes/index.html
	echo $(OUT_NOTES)

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
