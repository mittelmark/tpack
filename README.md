# tpack

[![license](https://img.shields.io/badge/license-BSD-lightgray.svg)](https://opensource.org/license/bsd)
[![Release](https://img.shields.io/github/v/release/mittelmark/tpack.svg?label=current+release)](https://github.com/mittelmark/tpack/releases)
![Downloads](https://img.shields.io/github/downloads/mittelmark/tpack/total)
![Commits](https://img.shields.io/github/commits-since/mittelmark/tpack/latest)
[![Docu](https://img.shields.io/badge/Docu-blue)](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/tpack/master/doc/tpack.html)

## NAME

__tpack__ - Tcl script packer - [Manual](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/tpack/master/doc/tpack.html)


There are two versions currently of that script: [tpack-tar.tcl](tpack-tar.tcl) which should work on Tcl 8.5 and Tcl 8.6 and [tpack-b64.tcl](tpack-b54.tcl) which should work with
Tcl 8.5, 8.6 and 9.0 in principle. For Tcl 8.4 enabled version see [here](https://github.com/mittelmark/tpack/blob/bdc26dc128c9e67f91d6efed66fe7576adc530a3/tpack.tcl).

## SYNOPSIS

```
### single file apps
tpack wrap APPNAME.tapp         
tpack wrap APPNAME.tapp --lz4
./APPNAME.tapp
```

For instance for an  application  _mini.tapp_,  you need a file mini.tcl and a
folder mini.vfs with the following structure:

```
lib main.tcl
```

Where _lib_ contains the Tcl packages your application needs and _main.tcl_ look
usually like this:

```
### file: mini.vfs/main.tcl
lappend auto_path [file join [file dirname [info script]] lib]
```

See the [samples folder](https://github.com/mittelmark/tpack/tree/main/samples)
for an example of such a mini-application and other example applcations.

## DESCRIPTION

__tpack__ is a Tcl script which can be used to deploy your Tcl  application to
other computers and users. It is not a virtual file system approach. 
During  the first  application  run files  will be  installed  in a  temporary
directly and used from there. Unpacking of files will be redone 
automatically if the files in the program folder are newer than those 
files in the temporary folder. 

As input you give your application file _app.tcl_ and a folder containing your
libraries _app.vfs/lib_. 
The  folder  structure  is the same as for the  starkit  approach,  by careful
design of the file 
_app.vfs/main.tcl_  the  same  folder  can be as  well  used  to for  building
starkits and tarkits.
The script  _tpack.tcl_ can create  standalone  applications  containing  some
tar-file loader, 
the application code from _app.tcl_ and and the library code from _app.vfs_. 

Installation of the created application is than easy: 

- rename _app.tapp_ to _app.bin_ or just _app_
- make it executable
- move it to a directory belonging to your _PATH_ variable

In case of two file applications:

- make the file _app.ttcl_ executable
- copy the files  _app.ttcl_  and _app.ttar_ to a directory  belonging to your
  _PATH_ variable

## INSTALLATION

Installation of the _tpack_ executable itself is as well easy, just copy the file _tpack.tcl_
as _tpack_ to a folder belonging to your _PATH_ variable. 

Here an example on how to do that on a Linux system using wget:

```
wget  https://raw.githubusercontent.com/mittelmark/tpack/main/tpack-b64.tcl -O tpack.tcl
chmod 755 tpack.tcl
mv tpack.tcl ~/bin/
```

## COMPARISON

Here a comparison table between three deployment strategies:

|  Deployment | files |  Compression  | Tclkit 8.4** | Tclkit 8.5 | Tclkit 8.6 | Tcl 8.4** | Tcl 8.5 | Tcl 8.6 | Tcl 9.0 |
|:-----------:|:-----:|:-------------:|:------------:|:----------:|:----------:|:---------:|:-------:|:-------:|:-------:|
| starkit     | 1     | yes          | yes           | yes        | yes        | no        | no      | no      | no      |
| zipkit      | 1     | yes           | no           | no         | no         | no        | no      | no      | yes     |
| tpack       | 1,2   | yes*          | yes          | yes        | yes        | yes       | yes     | yes     | yes     |


*_tpack_ can use the _lz4_  application  to  compress  the  script,  and at runtime
decompress the script without this  executable. So _lz4_ compression  with _tpack_
requires  an _lz4_  executable  during  file  creation  and at least  Tcl 8.5 at
runtime to unpack the code in the background before execution.

Before you deliver the tpack application files you can obviously compress them
yourself using _gzip_, _zip_ or other tools.

**Tcl/Tclkit 8.4** requires version of tpack before version 0.4.0 which you can retrieve from [here](https://github.com/mittelmark/tpack/blob/bdc26dc128c9e67f91d6efed66fe7576adc530a3/tpack.tcl)


## EXAMPLE APPLICATIONS

- [mkdoc](https://github.com/mittelmark/mkdoc)  - source  code  documentation tool
- [pantcl](https://github.com/mittelmark/pantcl) - reporting tool for literate
programming as pandoc filter
- [tmdoc](https://github.com/mittelmark/tmdoc) - literature programming with Tcl

## CHANGES

- 2025-01-01: v0.4.0 starting support for Tcl 9
- 2025-01-XX: v0.5.0 switched default from tar to base64 as the code storage as tar code had some issues

## LICENSE

```
BSD 3-Clause License

Copyright (c) 2024, Detlef Groth tpack code
Copyright (c) 2017 dbohdan pur Tcl lz4 decompression code
Copyright (c) 2013 Andreas Kupries andreas_kupries(at)users.sourceforge(dot)net (tar code)
Copyright (c) 2004 Aaron Faupell afaupell(at)users.sourceforge(sot)net (tar code)
#

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
