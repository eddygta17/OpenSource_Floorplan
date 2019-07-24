
magic -noconsole << EOF
drc off
box 0 0 0 0
drc off
lef read lef/osu018_stdcells.lef
lef read lef/picorv32.lef
lef read lef/picosoc_mem.lef
select top cell
def read $1
writeall force ${cellname}
EOF
