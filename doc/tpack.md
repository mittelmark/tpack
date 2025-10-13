---
title: tpack - Tcl application deployment
section: 1
header: User Manual
footer: tpack 0.6.0
author: Detlef Groth, University of Potsdam, Germany
date: 2025-10-13
---

## NAME 

_tpack_ - create single or two file Tcl applications based on libraries in tar/lz4 archives

## SYNOPSIS

```
$ tpack --help               # display usage information
$ tpack wrap app.tapp        # wraps app.tcl and app.vfs into app.tapp 
                             # where app.vfs is attached as base64 archive
$ tpack wrap app.tapp --lz4  # as above but use base64 and lz4 for compression
$ tpack init app.tcl app.vfs # creates initial file app.tcl and folder app.vfs
$ tpack init app             #            as above
$ tpack init app.vfs         # create initial folder app.vfs
$ tpack unwrap app.tapp      # extracts app.tcl and app.vfs out of app.tapp
```

## DESCRIPTION

The _tpack_ application can be used to simplify deployment of Tcl applications to other computers and customers.
The application can create single file Tcl applications. 
These single file applications, called tapp-files contain at the top the base64 / lz4 extraction code,
the main tcl script and an attached base64 archive where all files are encoded using base64 and file separation
lines containing the libraries required by this application file. At startup the base64 encoded files are
detached from the file and unpacked into a temporary folder from where the libraries are loaded. 
The compression with lz4 needs an installed lz4 executable, the decompression of
the build executable is embedded into the final application but requires a Tcl installation of at least 8.5.

The single file approach creates _app.tapp_ file out of _app.vfs_ and _app.tcl_.

```
tpack wrap app.tapp
```

The file _main.tcl_ in the vfs-folder should contain at least the following line:

```
lappend auto_path [file join [file dirname [info script]] lib]
```

The _tpack_ application provides as well a loader for default starkit layouts, so a fake starkit package so that 
as well existing starkits can be packed by _tpack_, here a _main.tcl_ file from the tknotepad application.

```
package require starkit
if {[starkit::startup] == "sourced"} return
package require app-tknotepad
```

In this case the application file tknotepad.tcl which is in the same directoy as _tknotepad.vfs_ can be just an empty file. It can as well contain code to handel command line arguments.
Here the file tknotepad.tcl:

```
proc usage {} {
    puts "Usage: tknotepad filename"
}
if {[info exists argv0] && $argv0 eq [info script] && [regexp tknotepad $argv0]} {
    if {[llength $argv] > -1 && [lsearch $argv --help] > -1} {
        usage
    } elseif {[llength $argv] > 0 && [file exists [lindex $argv 0]]} {
        openoninit [lindex $argv 0]
    }
}
```

That way you should be able to use your vfs-folder for creating tpacked applications
as well for creating starkits.

## INSTALLATION

Make this file [tpack-b64.tcl](https://raw.githubusercontent.com/mittelmark/tpack/refs/heads/main/tpack-b64.tcl)
executable and copy it as _tpack_ into a directory belonging to your
PATH environment. There are no other Tcl libraries required to install, just a working installation
of Tcl/Tk of at least Tcl 8.5 is required.

## EXAMPLE

Let's demonstrate a minimal application:

```
## FILE mini.tcl
#!/usr/bin/env tclsh
package require test
puts mini
puts [test::hello]
## FILE mini.vfs/main.tcl
lappend auto_path [file join [file dirname [info script]] lib]
## FILE mini.vfs/lib/test/pkgIndex.tcl
package ifneeded test 0.1 [list source [file join $dir test.tcl]]
## FILE mini.vfs/lib/test/test.tcl
package require Tcl
package provide test 0.1
namespace eval ::test { }
proc ::test::hello { } { puts "Hello World!" }
## EOF's
```
There is the possibility to create such a minimal application automatically for you if you start a new project
by using the command line options:

```
$ tpack init appname
# - appname.tcl and appname.vfs folder with main.tcl and
#   lib/test Tcl files will be created automatically for you.
```

The string _appname_ has to be replaced with the name of your application. 
If a the Tcl file or the VFS folder does already exists, _tpack_ for your safeness
will refuse to overwrite them. 
If the files were created, you can overwrite the Tcl file (_appname.tcl_)
with your own application and move your libraries into the folder 
_appname.vfs_.  If you are ready you call `tpack wrap appname.tcl appname.vfs` and 
you end up with two new files, _appname.ttcl_ your application code file, containing 
your code as well as some code to encode and decode base64 files.

Attention: if mini.tapp is executed directly in the directory where mini.vfs is 
located not the mini.tapp file but the folder will be used for the libraries. That can simplify the development.

You can rename mini.tapp to what every you like so `mini.bin` or even `mini`.

## CHANGELOG

- 2021-09-10 - release 0.1  - two file applications (ttcl and ttar) are working
- 2021-11-10 - release 0.2.0 
    - single file applications (ttap = ttcl+ttar in one file) are working as well
    - fake starkit::startup to load existing starkit apps without modification
    - build sample apps tknotepad, pandoc-tcl-filter, 
- 2021-11-26 - release 0.2.1 
    - bugfix: adding `package forget tar` after tar file loading to catch users `package require tar`
- 2022-02-16 - release 0.3.0
    - support for lz4 compression/decompression
- 2024-03-14 - release 0.3.1
    - docu updates
    - project moved to its own repo https://github.com/mittelmark/tpack
- 2025-01-01 - release 0.4.0
    - making it Tcl 9 aware
- 2025-01-02 - release 0.4.1
    - making it Tcl 9 aware, another fix
- 2025-01-03 - release 0.5.0 rewrite using base64 instead of tar and as well only supporting single file
               approach, so tapp files
- 2025-10-13 - release 0.6.0 lz4 compression set to 9 as lz4 v1.10 seems to have
               lower compression level as default

## TODO

- nsis installer for Windows, to deploy minimal Tcl/Tk with the application

## AUTHOR

  - Copyright (c) 2021-2025 Detlef Groth, University of Potsdam, Germany, dgroth(at)uni(minus)potsdam(dot)de (tpack code)
  - Copyright (c) 2017 dbohdan pur Tcl lz4 decompression code
  - Copyright (c) 2013 Andreas Kupries andreas_kupries(at)users.sourceforge(dot)net (tar code)
  - Copyright (c) 2004 Aaron Faupell afaupell(at)users.sourceforge(sot)net (tar code)

## LICENSE

```
BSD 3-Clause License

Copyright (c) 2021-2025 Detlef Groth, University of Potsdam, Germany

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```

