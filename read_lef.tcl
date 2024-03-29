#!/usr/bin/tclsh
#------------------------------------------------------------
# Opens the LEF file and then creates a dictionary
# of the STD cell's height and width into a file
#------------------------------------------------------------

set file_no 0
set overallcellcount 0
set areafile [open "cell_area.vlsisd" w]
puts $areafile $argc

while {![expr $file_no==$argc]} {
  
  set leffile "[lindex $argv $file_no]"  
  puts $areafile $leffile
  incr file_no
  
}
set file_no 0

while {![expr $file_no==$argc]} {

  set leffile [open "[lindex $argv $file_no]" r]
  set stdcellcount 0

  while { [gets $leffile data] >= 0 } {

      if {[string match "MACRO *" $data]} {
      set stdcellname [string map {"MACRO " ""} $data]

      while {![string match "* SIZE *" $data]} {
        gets $leffile data
      }

      if {[regexp {([0-9]+\.[0-9]+ BY)} $data width]} {
        set width [string map {" BY" ""} $width]
      }

      if {[regexp {(BY [0-9]+\.[0-9]+)} $data height]} {
        set height [string map {"BY " ""} $height]
      }

      set area [expr $width*$height]
      puts $areafile "$stdcellname $area $width $height"
      incr stdcellcount
      incr overallcellcount
      }
  }

  puts "INFO: There are $stdcellcount STD cells in the LEF file : [lindex $argv $file_no]"
  incr file_no
  close $leffile
}

close $areafile
puts "INFO: There are $overallcellcount STD cells in all."
