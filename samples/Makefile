##-*- makefile -*-############################################################
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : MicroEmacs User
#  Created       : 2025-01-04 08:08:06
#  Last Modified : <250104.0916>
#
#  Description	
#
#  Notes
#
#  History
#	
#  $Log$
#
##############################################################################
#
#  Copyright (c) 2025 MicroEmacs User.
# 
#  All Rights Reserved.
# 
#  This  document  may  not, in  whole  or in  part, be  copied,  photocopied,
#  reproduced,  translated,  or  reduced to any  electronic  medium or machine
#  readable form without prior written consent from MicroEmacs User.
#
##############################################################################

TCL9=~/.local/opt/bin/tclsh9.0
TCL8=tclsh
tcl9:
	$(TCL9) ../tpack-b64.tcl wrap md2html.tapp
	cp md2html.tapp bin/md2html.9bin
	$(TCL9) ./bin/md2html.9bin -h
	$(TCL9) ../tpack-b64.tcl wrap md2html.tapp --lz4
	cp md2html.tapp bin/md2html.9zbin
	$(TCL9) ./bin/md2html.9zbin -h
	./bin/md2html.9zbin -h	
tcl8:
	$(TCL8) ../tpack-b64.tcl wrap md2html.tapp
	cp md2html.tapp bin/md2html.9bin
	$(TCL8) ./bin/md2html.9bin -h
	$(TCL8) ../tpack-b64.tcl wrap md2html.tapp --lz4
	cp md2html.tapp bin/md2html.9zbin
	$(TCL8) ./bin/md2html.9zbin -h

### example for a binary extension wrapping
### Tcl9 not ready as dnd lib for Tcl is still missing
### See: https://github.com/petasis/tkdnd
tknotepad:
	$(TCL8) ../tpack-b64.tcl wrap tknotepad.tapp --lz4
	cp tknotepad.tapp bin/tknotepad.zbin
	./bin/tknotepad.zbin

mini8:
	$(TCL8) ../tpack-b64.tcl wrap mini.tapp
	cp mini.tapp bin/mini.bin
	$(TCL8) ../tpack-b64.tcl wrap mini.tapp	 --lz4
	cp mini.tapp bin/mini.zbin
	$(TCL8) ./bin/mini.zbin
mini9:
	$(TCL9) ../tpack-b64.tcl wrap mini.tapp
	cp mini.tapp bin/mini.bin
	$(TCL9) ../tpack-b64.tcl wrap mini.tapp	 --lz4
	cp mini.tapp bin/mini.zbin
	$(TCL9) ./bin/mini.zbin
