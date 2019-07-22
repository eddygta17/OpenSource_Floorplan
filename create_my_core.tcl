#!/usr/bin/tclsh
#------------------------------------------------------------
# Creates a core using the user inputs of aspect ratio 
# and utilisation factor
#------------------------------------------------------------

set cell_used_file [open "cell_used.vlsisd" r]
gets $cell_used_file data
set cell_area_file [open "cell_area.vlsisd" r]
set core_area_file [open "core_area.vlsisd" w]
set areanet 0.00
set ucellcount 0

while { [gets $cell_used_file data] >= 0 } {
    set cellsused($ucellcount) $data
    incr ucellcount
}

while { [gets $cell_area_file data] >= 0 } {
    set data [split "$data"]
    set stdcells([lindex $data 0]) [lindex $data 1]
}


for { set index 0}  {$index < $ucellcount} {incr index} {
      set temp $cellsused($index)
      set areanet [expr $areanet + $stdcells($temp)]
}

puts "INFO: The area of the given net is: $areanet"
close $cell_area_file
close $cell_used_file

set ufactor [lindex $argv 0]
set aratio [lindex $argv 1]
set areacore [expr $areanet/$ufactor]
set heightcore [expr $aratio*$areacore]
set heightcore [expr { sqrt($heightcore) }]
set widthcore [expr $areacore/$heightcore]

puts "INFO: The height of the core should be: $heightcore"
puts "INFO: The width of the core should be: $widthcore"
puts "INFO: The area of the core is: $areacore"

puts $core_area_file "$widthcore"
puts $core_area_file "$heightcore"
close $core_area_file

