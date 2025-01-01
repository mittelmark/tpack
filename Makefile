

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
	cd test && tclsh ../tpack.tcl wrap mini.tapp
	cd test && mv mini.tapp mini.bin
	cd test && chmod 755 mini.bin
	cd test && ./mini.bin
