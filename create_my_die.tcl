#!/usr/bin/tclsh
#------------------------------------------------------------
# Creates a die using the input of core to die width 
# and then creates an output of DEF file
#------------------------------------------------------------

set core_area_file [open "core_area.vlsisd" r]
set cell_used_file [open "cell_used.vlsisd" r]


gets $cell_used_file verilogfile
gets $core_area_file widthcore
gets $core_area_file heightcore

close $cell_used_file
close $core_area_file

set def_out [lindex $argv 4]
eval exec ./vlog2Def -o $def_out $verilogfile
set def_file [open "$def_out" r]
set def_lines [split [read $def_file] "\n"]
set def_file [open "Die$def_out" w]


set heightdie [expr $heightcore+[lindex $argv 0]+[lindex $argv 1]]
set widthdie  [expr $widthcore+[lindex $argv 2]+[lindex $argv 3]]
set areadie [expr $heightdie*$widthdie]

puts "INFO: The height of the die should be: $heightdie"
puts "INFO: The width of the die should be: $widthdie"
puts "INFO: The area of the die is: $areadie"
puts "DIEAREA ( 0 0 ) ( $widthdie $heightdie ) ;"

foreach line $def_lines {
    if {[string match "UNITS DISTANCE*" $line]} {
        puts $def_file $line
        puts $def_file ""
        puts $def_file "DIEAREA ( 0 0 ) ( $widthdie $heightdie ) ;"
        puts $def_file ""
    } else {
        puts $def_file $line
    }
}
close $def_file

eval exec ./magic.sh $def_out
