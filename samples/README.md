---
title: Sample applications build with tpack
author: Detlef Groth, University of Potsdam, Germany
date: 2025-01-04 09:40
---

## README tpack samples

Ths folder  contains the  following  examples to illustrate on how to wrap Tcl
applications as single Tcl files with all required  libraries  embedded within
that script.

- mini.tcl / mini.vfs - a minimal application just requiring a single library
- md2html.tcl  / md2html.vfs - a simple command  line  application  for  converting
  Markdown documents into HTML using two tcllib libraries
- tknotepad.tcl / tknotepad.vfs - the old tknotepad  application  wrapped with
  embedded  binary  files to  enable  drag and drop  using  the tkdnd  library
  (currently only Tcl 8.6 shared libaries for Linux here provided)
  
If you have downloaded these examples, you might created wrapped  applications
for example, by using this command:

```
tclsh ../tpack-b64.tcl wrap mini.tapp
```

If you have installed  _tpack-b64.tcl_ as _tpack_ into your _PATH_ you can then just
write:

```
tpack wrap mini.tapp
```

