This is my personal contanct page - [nindwen.blue](https://nindwen.blue).

### Structure

When `make` is executed, it builds the index page as follows:

 * [head.html](head.html) 
 * `sass` [main.scss](main.scss)
 * [head2.html](head2.html)
 * `pandoc` [index.md](index.md)
 * [foot.html](foot.html)

Makefile also builds a "notes" directory, with markdown files built based on [notes-template.html](notes-template.html) and then a index file is built with [build_index.rb](build_index.rb).
