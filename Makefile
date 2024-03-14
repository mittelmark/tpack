

docu:
	perl -ne "/^#'/ and print" tpack.tcl | perl -pe 's/^.. ?//' > doc/tpack.md
	cd doc && pandoc tpack.md -o tpack.html --css mini.css -s
	cd doc && pandoc tpack.md -s -t man > tpack.1
