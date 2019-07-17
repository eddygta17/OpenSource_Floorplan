###############################################################################
# Opens the LEF file and then creates a dictionary
# of the STD cell's height and width
###############################################################################
set leffile [open "[lindex $argv 0]" r]
set stdcellcount 0
set stdcellname "NONE"
while { [gets $leffile data] >= 0 } {
    if {[string match "MACRO *" $data]} {
    set stdcellname [string map {"MACRO " ""} $data]
    while {![string match "* SIZE *" $data]} {
      gets $leffile data
    }
    set temp [split "$data"]
    set stdcells($stdcellname,0) [lindex $temp 3]
    set stdcells($stdcellname,1) [lindex $temp 5]
    incr stdcellcount
    }

}
close $leffile
puts "INFO: There are $stdcellcount STD cells in the given LEF file."
###############################################################################
# Opens the Verilog file and skips the firt few lines then
# creates an array of cells used and notes the cell count
###############################################################################
set verilogfile [open "[lindex $argv 1]" r]
set ucellcount 0
gets $verilogfile data
while {[string match "module*" $data] || [string match "" $data] || [string match "input*" $data] || [string match "output*" $data] || [string match "wire*" $data] || [string match "parameter*" $data]} {
  gets $verilogfile data
}

while { ![string match "endmodule*" $data] } {
    while {[string match "" $data]} {
      gets $verilogfile data
    }
    if {[regexp {([A-Z]+)([?]*)} $data a]} {
     set temp [split "$data"]
     set cellsused($ucellcount) [lindex $temp 0]
     #puts "$cellsused($ucellcount)"
     gets $verilogfile data
     incr ucellcount
   }
}
close $verilogfile
puts "INFO: There were $ucellcount cells used in the layout."
###############################################################################
# Checks the used cell against the value stored
# in the dictionay and gets it's height and width
# then calcuates the area as sigma(height* width)
###############################################################################
set areanet 0.00
for { set a 0}  {$a < $ucellcount} {incr a} {
      set temp $cellsused($a)
      set width $stdcells($temp,0)
      set height $stdcells($temp,1)
      set areanet [expr $areanet + $height*$width  ]
}
puts "INFO: The area of the net is: $areanet"
###############################################################################
# Calculate the height and width of the core using the 
# utilisation factor given by user
################################################################################
set ufactor [lindex $argv 2]
set aratio [lindex $argv 3]
set areacore [expr $areanet/$ufactor]
set heightcore [expr $aratio*$areacore]
set heightcore [expr { sqrt($heightcore) }]
set widthcore [expr $areacore/$heightcore]
puts "INFO: The height of the core should be: $heightcore"
puts "INFO: The width of the core should be: $widthcore"
puts "INFO: The area of the core is: $areacore"
set heightdie [expr $heightcore+[lindex $argv 4]+[lindex $argv 5]]
set widthdie  [expr $widthcore+[lindex $argv 6]+[lindex $argv 7]]
set areadie [expr $heightdie*$widthdie]
puts "INFO: The height of the die should be: $heightdie"
puts "INFO: The width of the dieshould be: $widthdie"
puts "INFO: The area of the die is is: $areadie"
puts "DIEAREA ( 0 0 ) ( $widthdie $heightdie ) ;"

