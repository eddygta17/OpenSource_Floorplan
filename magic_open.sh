magic -T /usr/local/share/qflow/tech/osu018/SCN6M_SUBM.10.tech -noconsole << EOF
drc off
lef read lef/osu018_stdcells.lef
lef read lef/picorv32.lef
lef read lef/picosoc_mem.lef
load $1 -force
EOF
 
