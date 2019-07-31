# OpenSource Floorplan
<Project description here>

## Getting Started
Clone the code to your machine and then change the current directory to **OpenSource_Floorplan**,by executing these commands in a terminal.
1. `git clone https://github.com/eddygta17/OpenSource_Floorplan.git`
2. `cd OpenSource_Floorplan`
3. `chmod 777 permissions.sh`
4. `./permissions.sh`



### Prerequisites
Most Unix / Linux operating system distributions, as well as Mac OS X, include Tcl/Tk.Magic a venerable VLSI layout tool, written by John Ousterhout is also required.

If not already installed, you can use your system's package manager to install the appropriate packages.
For example, on a Debian system, you can type

`sudo apt-get install tcl`

`sudo apt-get install magic`


### Usage

##### read_lef
Reads all the given LEF files and generates the file **cell_area.vlsisd** with all the STD cell names, their area, width and height.

`./read_lef.tcl <list_of_all_lef_files_seperated_by_space>`

<!-- read_lib
Reads all the given LIB files and generates the file **cell_area.vlsisd** with all the STD cell names and their area.

`./read_lib.tcl <list_of_all_lib_files_seperated_by_space>`-->

##### read_verilog
Reads the given verilog file and generates the file **cell_used.vlsisd** with the names of the cells used in the design.

`./read_verilog.tcl <verilog_file>`

##### create_my_core
Calculates the area of the net from previously generated files and then creates the core using the user given inputs of aspect ratio and utilisation factor.

`./create_my_core.tcl <utilisation_factor> <aspect_ratio>`

##### create_my_die
Computes the die area for the design from core area and user defined core to die widths then creates a DEF file.

`./create_my_die.tcl <core2die_top> <core2die_bottom> <core2die_left> <core2die_right> <output_def_file>`
