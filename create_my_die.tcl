#!/usr/bin/tclsh
#------------------------------------------------------------
# Creates a die using the inputs core to die width 
# and then creates an output of DEF file
#------------------------------------------------------------

set core_area_file [open "core_area.vlsisd" r]
set cell_used_file [open "cell_used.vlsisd" r]
gets $cell_used_file verilogfile
gets $core_area_file widthcore
gets $core_area_file heightcore
close $cell_used_file
close $core_area_file

set heightdie [expr $heightcore+[lindex $argv 0]+[lindex $argv 1]]
set widthdie  [expr $widthcore+[lindex $argv 2]+[lindex $argv 3]]
set areadie [expr $heightdie*$widthdie]

puts "INFO: The height of the die should be: $heightdie"
puts "INFO: The width of the die should be: $widthdie"
puts "INFO: The area of the die is is: $areadie"
puts "DIEAREA ( 0 0 ) ( $widthdie $heightdie ) ;"
[exec cowsay "moo"]