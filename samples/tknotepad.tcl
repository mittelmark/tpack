#!/usr/bin/env tclsh
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
