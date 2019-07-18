#!/usr/bin/tclsh
#------------------------------------------------------------
# Opens the LEF file and then creates a dictionary
# of the STD cell's height and width into a file
#------------------------------------------------------------
set file_no 0
set overallcellcount 0
set areafile [open "cell_area.vlsisd" w]

while {![expr $file_no==$argc]} {
  
  set leffile [open "[lindex $argv $file_no]" r]
  set stdcellcount 0
  
  while { [gets $leffile data] >= 0 } {
      
      if {[string match "MACRO *" $data]} {
      set stdcellname [string map {"MACRO " ""} $data]
      
      while {![string match "* SIZE *" $data]} {
        gets $leffile data
      }
      
      set temp [split "$data"]
      set stdcells($stdcellname,0) [lindex $temp 3]
      set stdcells($stdcellname,1) [lindex $temp 5]
      set area [expr $stdcells($stdcellname,0)*$stdcells($stdcellname,1)]
      puts $areafile "$stdcellname $area $stdcells($stdcellname,0) $stdcells($stdcellname,1)"
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
