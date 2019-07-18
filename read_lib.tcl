#!/usr/bin/tclsh
#------------------------------------------------------------
# Opens the LIB file and then creates a dictionary
# of the STD cell's area into a file
#------------------------------------------------------------
set file_no 0
set overallcellcount 0
set areafile [open "cell_area.vlsisd" w]
while {![expr $file_no==$argc]} {
  set libfile [open "[lindex $argv $file_no]" r]
  set stdcellcount 0
  set stdcellname "NONE"
  while { [gets $libfile data] >= 0 } {
      if {[string match "cell *" $data]} {
        set temp $data
        set stdcellname [split "$temp"]
        set stdcellname [lindex $stdcellname 1]
        set stdcellname [string map {"(" ""} $stdcellname]
        set stdcellname [string map {")" ""} $stdcellname]
        if {[string match "*area *" $data]} {
          set temp [split "$data"]
          set temp [string map {";" ""} $temp]
          set stdcells($stdcellname,0) [lindex $temp 5]
        } else {
          while {![string match "*area *" $data]} {
            gets $libfile data
          }
          set temp [split "$data"]
          set temp [string map {";" ""} $temp]
          set stdcells($stdcellname,0) [lindex $temp 2]
        }
        puts $areafile "$stdcellname $stdcells($stdcellname,0)"
        incr stdcellcount
        incr overallcellcount
      }
  }
  puts "INFO: There are $stdcellcount STD cells in the LIB file : [lindex $argv $file_no]"
  incr file_no
  close $libfile
}
close $areafile
puts "INFO: There are $overallcellcount STD cells in all."
