# OpenSource Floorplan
<Project description here>

## Getting Started
Clone the code to your machine and then change the current directory to **OpenSource_Floorplan**,by executing these commands in a terminal.
1. `git clone https://github.com/eddygta17/OpenSource_Floorplan.git`
2. `cd OpenSource_Floorplan`

### Prerequisites
Most Unix / Linux operating system distributions, as well as Mac OS X, include Tcl/Tk.
If not already installed, you can use your system's package manager to install the appropriate packages.
For example, on a Debian system, you can type

`sudo apt-get install tcl`

### Usage
###### areatest
Calculates the area of the core from froma LEF file of STD cells and a synthesised verilog netlist.

`tclsh areatest.tcl <LEF_file> <verilog_file> <utilisation_factor> <aspect_ratio> <core2die_top> <core2die_bottom> <core2die_left> <core2die_right>`

###### read_lef
Reads all the given LEF files and generates the file **cell_area.vlsisd** with all the STD cell names, their area, width and height.

`tclsh read_lef.tcl <list_of_all_lef_files_seperated_by_space>`

###### read_lib
Reads all the given LIB files and generates the file **cell_area.vlsisd** with all the STD cell names and their area.

`tclsh read_lib.tcl <list_of_all_lib_files_seperated_by_space>`
