###############
# Opens the Verilog file and skips the first few lines then
# creates an array of cells used and notes the cell count
##############
set verilogfile [open "[lindex $argv 0]" r]
set cellfile [open "cell_used.vlsisd" w]
set ucellcount 0
gets $verilogfile data
 while {[string match "module*" $data] ||
        [string match "endmodule*" $data] ||
        [string match "input*" $data] ||
        [string match "output*" $data] ||
        [string match "wire*" $data] ||
        [string match "parameter*" $data] ||
        [string match "" $data] ||
        [string match "reg*" $data] } {
          gets $verilogfile data
        }
while { ![eof $verilogfile] } {
    #puts $data
    if {[regexp { \(} $data temp]} {
     #puts $data
     set temp [split "$data"]
     set cellsused($ucellcount) [lindex $temp 0]
     puts $cellfile "$cellsused($ucellcount)"
     incr ucellcount
   }
   gets $verilogfile data
}
close $verilogfile
puts "INFO: There were $ucellcount cells used in the layout."
