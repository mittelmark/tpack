##############################################################################
#
#  			Copyright 2003 MPIMG Berlin, Germany.
#			      All Rights Reserved
#
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Dr. Detlef Groth
#  Created       : Tue Mar 4 06:00:33 2003
#  Last Modified : <120206.2237>
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
#  Copyright (c) 2003 MPIMG Berlin, Germany.
# 
#  All Rights Reserved.
# 
#  This  document  may  not, in  whole  or in  part, be  copied,  photocopied,
#  reproduced,  translated,  or  reduced to any  electronic  medium or machine
#  readable form without prior written consent from MPIMG Berlin, Germany.
#
##############################################################################



package require iniparse

proc ini_mnu_install {mnu section cmd max} {
    global var
    for {set i 1} {$i <= $max} {incr i 1} {
        set val [readini $var(inifile) $section $i]
        set u [expr $i / 10]
        if {$val !=0} {
            $mnu add command -label "$i $val" \
                      -underline $u  -command "$cmd $val" 
        } else {
            $mnu add command -label "$i " -underline $u  -state disabled
        }
        
    }
}
proc ini_mnu_update {mnu section cmd {max 10}} {
    global var
    
    # inactivate
    for {set i 1} {$i <= $max} {incr i 1} {
        set j [expr $i -1 ]
        $mnu entryconfigure  $j -label "$i ..." 
        $mnu entryconfigure  $j -state disabled
       
    }
 
    for {set i 1} {$i <= $max} {incr i 1} {
        set j [expr $i -1 ]
        set inival [readini $var(inifile) $section $i]
        if {$inival != 0} {
            $mnu entryconfigure  $j -label "$i $inival" 
            $mnu entryconfigure  $j -state normal
            $mnu entryconfigure  $j -command "$cmd $inival"
        } 
    }
}
proc resource_load {} {
    global $argv
    set var(resfile) [file rootname $argv0].res
    if [file exists $var(resfile)] {
        if [catch {option readfile $var(resfile) startup} err] {
            puts stderr "error in $var(resfile): $err"
        }
    }
    
}
proc ini_set {key opt val} {
    global var
    writeini $var(inifile) $key $opt $val
    iniparse:flushfile $var(inifile)
}
proc ini_get {key opt} {
    global var
    return [readini $var(inifile) $key $opt]
}

proc ini_option_set {opt val} {
    global var
    writeini $var(inifile) OPTIONS $opt $val
    iniparse:flushfile $var(inifile)
}
proc ini_option_get {opt} {
    global var
    return [readini $var(inifile) OPTIONS $opt]
}
proc ini_unshift {key val {max 10}} {
    global var
    # check if value is there
    set x $max
    for {set i 1} {$i <= $max} {incr i 1} {
        if {[string equal [readini $var(inifile) $key $i] $val]} {
            set x $i
            #puts $i
            break
        }
    }
    for {set i $x} {$i > 0} {incr i -1} {
     
        set j [expr $i - 1]
        #puts "x: $x , i: $i, j: $j"
        writeini $var(inifile) $key $i [readini $var(inifile) $key $j]
         
    }
    writeini $var(inifile) $key 1 $val
    iniparse:flushfile $var(inifile)
}
proc ini_write {} {
    global var
    iniparse:flushfile $var(inifile)
}
proc ini_load {args} {
    global argv0 var env
    set ininame "$var(appname).ini"
    set ininame [file join $env(HOME) $ininame]
    if {[file exists $ininame]} {
        set var(inifile) [iniparse:openfile $ininame]   
    } else {
        set options 0
        set OUTPUT [open $ininame w 0600]
     
       
     
        foreach {ini n} $args {
          
            if {$n == 1} {
                # output one value-options
                if {$options == 0} {
                    puts $OUTPUT "\[OPTIONS\]"
                    incr options
                } 
                puts $OUTPUT "$ini=0"
            } else {
                #output arrays
                puts $OUTPUT "\[$ini\]"
                for {set i 1} {$i <= $n} {incr i 1} {
                    puts $OUTPUT "$i=0"
                }
            }
        }
        close $OUTPUT  
        ini_load
    }
}
