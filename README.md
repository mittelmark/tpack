# tpack

## NAME

__tpack__ - Tcl script packer - [Manual](https://htmlpreview.github.io/?https://raw.githubusercontent.com/mittelmark/tpack/master/doc/tpack.html)

## SYNOPSIS

```
### single file apps
tpack APPNAME.tapp         
tpack APPNAME.tapp --lz4
### two file apps
tpack wrap APPNAME.tcl APPNAME.vfs  
```

You need a file mini.tcl and a folder mini.vfs with the following structure:

```
lib main.tcl
```

Where _lib_ contains the Tcl packages your application needs and _main.tcl_ look
usually like this:

```
### file: mini.vfs/main.tcl
lappend auto_path [file join [file dirname [info script]] lib]
```

See the [sample  folder](https://github.com/mittelmark/tpack/tree/main/sample)
for an example of a mini-application.

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
wget https://raw.githubusercontent.com/mittelmark/tpack/main/tpack.tcl
chmod 755 tpack.tcl
mv tpack.tcl ~/bin/
```

## COMPARISON

Here a comparison table between three deployment strategies:

|  Deployment | files |  Compression  | Tclkit 8.4 | Tclkit 8.5 | Tclkit 8.6 |Tclkit 8.7 | Tcl 8.4 | Tcl 8.5 | Tcl 8.6 | Tcl 8.7 |
|:-----------:|:-----:|:-------------:|:----------:|:----------:|:----------:|:----------:|:-------:|:-------:|:-------:|:-------:|
| starkit     | 1     |  yes         |  yes        | yes        | yes        | yes        | no | no | no | no |
| zipkit      | 1     | yes | no | no | no | yes | no | no | no | yes |
| tpack       | 1,2   | yes* | yes | yes | yes | yes | yes | yes | yes | yes |


*_tpack_ can use the _lz4_  application  to  compress  the  script,  and at runtime
decompress the script without this  executable. So _lz4_ compression  with _tpack_
requires  an _lz4_  executable  during  file  creation  and at least  Tcl 8.5 at
runtime to unpack the code in the background before execution.

Before you deliver the tpack application files you can obviously compress them
yourself using _gzip_, _zip_ or other tools.


## EXAMPLE APPLICATIONS

- [mkdoc](https://github.com/mittelmark/mkdoc)  - source  code  documentation tool
- [pantcl](https://github.com/mittelmark/pantcl) - reporting tool for literate
programming as pandoc filter
- [tmdoc](https://github.com/mittelmark/tmdoc) - literature programming with Tcl
