package require Markdown
namespace eval ::md2html {
    variable HLP
    set HLP "
 md2html - Markdown to HTML converter
 Detlef Groth, University of Potsdam, 2025
    
    Usage: __APP__ -h|--help MARKDOWNFILE|- HTMLFILE|-
    
    Options:
    
      -h, --help       : display this help page
    
    Arguments:
    
      MARKDOWNFILE|-   : either a Markdown file or 
                         reading from stdin if '-' is given
      HTMLFILE|-       : either a HTML file to be used as output
                         or stdout if '-' is given
"    
set HEADER "<html>\n  <head>\n    <title>__TITLE__</title>\n  </head>\n<body>\n"    
set FOOTER "\n</body>\n</html>\n"
}
proc ::md2html::help {app} {
    variable HLP
    puts [regsub -all {__APP__} $HLP $app]
}
proc ::md2html::usage {app} {
    puts "Usage: $app -h,--help MARKDOWNFILE|- HTMLFILE"
}

proc ::md2html::main {argv} {
    variable HEADER
    variable FOOTER
    set filename [lindex $argv 0]
    if [catch {open $filename r} infh] {
        puts stderr "Cannot open $filename: $infh"
        exit
    } else {
        set content [read $infh]
        set html [Markdown::convert $content]
        close $infh
        if {[lindex $argv 1] eq "-"} {
            puts [regsub __TITLE__ $HEADER [file rootname [file tail [lindex $argv 0]]]]
            puts $html
            puts $FOOTER
        } else {
            set out [open [lindex $argv 1] w 0600]
            puts $out [regsub __TITLE__ $HEADER [file rootname [file tail [lindex $argv 0]]]]
            puts $out $html
            puts $out $FOOTER
            close $out
        }
    }
}
if {[info exists argv0] && $argv0 eq [info script]} {
    if {[lsearch -regex $argv {(-h|--help)}] > -1} {
        ::md2html::help $argv0 
    } elseif {[llength $argv] != 2} {
        ::md2html::usage $argv0
    } elseif {![file exists [lindex $argv 0]] && [lindex $argv 0] != "-"} {
        puts "Error: The file [lindex $argv 0] does not exists!"
        ::md2html::usage $argv0
    } elseif {![regexp -nocase {html?$} [lindex $argv 1]] && [lindex $argv 1] != "-"} {
        puts "Error: The file [lindex $argv 1] is not a HTML file or not stdout!"
        ::md2html::usage $argv0
    } else {
        ::md2html::main $argv
    }
}
