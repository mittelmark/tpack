# tpack

## NAME

__tpack__ - Tcl script packer

## SYNOPSIS



```
tpack mini.tapp         
tpack mini.tapp --lz4
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

Installation of the application is than easy: 

- rename _app.tapp_ to _app.bin_ or just _app_
- make it executable
- move it to a directory belonging to your _PATH_ variable

## INSTALLATION

Installation of the _tpack_ executable is easy, just copy the file _tpack.tcl_
as _tpack_ to a folder belonging to your _PATH_ variable. 

Here an example on how to do that on a Linux system using wget:

```
wget https://github.com/mittelmark/tpack/blob/main/tpack.tcl
chmod 755 tpack.tcl
mv tpack.tcl ~/bin/
```



## COMPARISON

Here a comparison table between three deployment strategies:

|  Deployment | files |  Compression  | Tclkit 8.4 | Tclkit 8.5 | Tclkit 8.6 |Tclkit 8.7 | Tcl 8.4 | Tcl 8.5 | Tcl 8.6 | Tcl 8.7 |
|:-----------:|:-----:|:-----------:|:----------:|:----------:|:----------:|:----------:|:-------:|:-------:|:-------:|:-------:|
| starkit     | 1     |  yes         |  yes        | yes        | yes        | yes        | no | no | no | no |
| zipkit      | 1     | yes | no | no | no | yes | no | no | no | yes |
| tpack       | 1,2   | yes* | yes | yes | yes | yes | yes | yes | yes | yes |

*Before you deliver the tpack application files you can obviously compress them yourself using gzip, zip or other tools, lz4 expression requires an lz4 executable during file creation and at least Tcl 8.5 at runtime.


