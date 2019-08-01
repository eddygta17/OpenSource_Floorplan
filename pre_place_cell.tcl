#!/usr/bin/tclsh
#------------------------------------------------------------
# Fixes the location of the cell by taking coordnates from h 
# the user
#------------------------------------------------------------

set def_out [lindex $argv 0]
set cell [lindex $argv 1]
set x [lindex $argv 2]
set y [lindex $argv 3]

set def_file [open "$def_out" r]
set def_lines [split [read $def_file] "\n"]
set def_file [open "$def_out" w]

set cell_area_file [open "cell_area.vlsisd" r]
set core_area_file [open "core_area.vlsisd" r]
gets $core_area_file width
gets $core_area_file height
close $core_area_file

while { [gets $cell_area_file data] >= 0 } {

    set data [split "$data"]
    set stdcells([lindex $data 0],1) [lindex $data 2]
    set stdcells([lindex $data 0],2) [lindex $data 3]

}
close $cell_area_file

set xnew [expr $stdcells($cell,1)+$x]
set ynew [expr $stdcells($cell,2)+$y]
if { $ynew>[expr $height*100] || $xnew>[expr $width*100] } {

    puts "ERROR: Enter values within the COREAREA. Exiting the program."
    exit

}

set flag 0
foreach line $def_lines {

    if {[string match "COMPONENTS *" $line]} {

        set flag 1
        puts $def_file $line
        continue

    } elseif {[string match "END COMPONENTS*" $line]} {

        set flag 0
        puts $def_file $line
        continue

    }

    if {$flag} {

        if {[string match "*$cell*" $line]} {

            if {[string match "*FIXED*" $line]} {
                
                puts "WARNING: The  cell was already FIXED. Overwriting the values."
                set line [lindex [split $line "+"] 0]
                set line "$line+ FIXED ( $x $y ) N ;"
                puts $line
                

            } elseif {[string match "*UNPLACED*" $line]} {

                set line [string map {"+ UNPLACED ;" ""} $line]
                set line "$line+ FIXED ( $x $y ) N ;"
                puts $line
                
            } else {
                
                set line [string map {";" ""} $line]
                set line "$line+ FIXED ( $x $y ) N ;"
                puts $line

            }
            
            
        }

    } 
    puts $def_file $line

}

close $def_file
