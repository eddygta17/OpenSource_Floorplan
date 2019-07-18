# OpenSource Floorplan
<Project description here>

## Getting Started
Clone the code to your machine and then change the current directory to **OpenSource_Floorplan**,by executing these commands in a terminal.
1. `git clone https://github.com/eddygta17/OpenSource_Floorplan.git`
2. `cd OpenSource_Floorplan`
3. `chmod 777 read_lef.tcl`
4. `chmod 777 read_lib.tcl`
5. `chmod 777 areatest.tcl` 

### Prerequisites
Most Unix / Linux operating system distributions, as well as Mac OS X, include Tcl/Tk.
If not already installed, you can use your system's package manager to install the appropriate packages.
For example, on a Debian system, you can type

`sudo apt-get install tcl`

### Usage
###### areatest
Calculates the area of the core from froma LEF file of STD cells and a synthesised verilog netlist.

`./areatest.tcl <LEF_file> <verilog_file> <utilisation_factor> <aspect_ratio> <core2die_top> <core2die_bottom> <core2die_left> <core2die_right>`

###### read_lef
Reads all the given LEF files and generates the file **cell_area.vlsisd** with all the STD cell names, their area, width and height.

`./read_lef.tcl <list_of_all_lef_files_seperated_by_space>`

###### read_lib
Reads all the given LIB files and generates the file **cell_area.vlsisd** with all the STD cell names and their area.

`./read_lib.tcl <list_of_all_lib_files_seperated_by_space>`

###### read_verilog
Reads the given verilog file and generates the file **cell_used.vlsisd** with the names of the cells used in the design.

`./read_verilog.tcl <verilog_file>`
