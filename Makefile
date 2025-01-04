TCL9=~/.local/opt/bin/tclsh9.0
tpack=tpack
docu:
	perl -ne "/^#'/ and print" tpack.tcl | perl -pe 's/^.. ?//' > doc/tpack.md
	cd doc && pandoc tpack.md -o tpack.html --css mini.css -s
	cd doc && pandoc tpack.md -s -t man > tpack.1

test:
	[[ ! -d test ]] && mkdir test
	cd test && echo "#!/usr/bin/env tclsh" > mini.tcl
	cd test && echo "package require test" >> mini.tcl
	cd test && echo "puts mini" >> mini.tcl
	cd test && echo "puts [::test::hello]" >> mini.tcl
	cd test && mkdir -p mini.vfs/lib/test
	cd test && echo "lappend auto_path [file join [file dirname [info script]] lib]" > mini.vfs/main.tcl
	cd test && echo "package ifneeded test 0.1 [list source [file join \$$dir test.tcl]]" > mini.vfs/lib/test/pkgIndex.tcl
	cd test && echo -e "package require Tcl\npackage provide test 0.1\nnamespace eval ::test { }\n" > mini.vfs/lib/test/test.tcl
	cd test && echo "proc ::test::hello { } { puts \"Hello World!\" }" >> mini.vfs/lib/test/test.tcl
	cd test && tclsh ../$(tpack).tcl wrap mini.tapp
	cd test && mv mini.tapp ../bin/mini.bin
	chmod 755 bin/mini.bin
	./bin/mini.bin
	$(TCL9) bin/mini.bin	
	cd test && tclsh ../$(tpack).tcl wrap mini.tapp --lz4	
	cd test && mv mini.tapp ../bin/mini.zbin
	chmod 755 bin/mini.zbin
	./bin/mini.zbin
	$(TCL9) bin/mini.zbin		
md2html:
	-mkdir md2html.vfs
	echo "lappend auto_path [file join [file dirname [info script]] lib]" > md2html.vfs/main.tcl
	-mkdir -p md2html.vfs/lib/markdown
	cp ~/workspace/tcllib/modules/markdown/*.tcl md2html.vfs/lib/markdown/
	echo "package require Markdown" > md2html.tcl
	echo "puts [package present Markdown]" >> md2html.tcl
	tclsh tpack-b64.tcl wrap md2html.tapp
	cp md2html.tapp bin/md2html.bin
	tclsh tpack-b64.tcl md2html.tapp --lz4
	cp md2html.tapp bin/md2html.zbin
	
