TITLE=OCaml\ Syntax\ Cheatsheet

index.html : $(TITLE).html
	mv '$<' $@

$(TITLE).html : page-$(TITLE).odoc
	odoc html '$<' --output-dir .
	odoc support-files --output-dir .

page-$(TITLE).odoc : $(TITLE).mld
	odoc compile '$<'

.PHONY : clean
clean :
	rm highlight.pack.js index.html odoc.css *.odoc *.odocl
