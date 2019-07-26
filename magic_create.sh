magic -dnull -noconsole << EOF
drc off
lef read lef/osu018_stdcells.lef
lef read lef/picorv32.lef
lef read lef/picosoc_mem.lef
def read $1
select top cell
writeall force ${cellname}
quit -noprompt
EOF
