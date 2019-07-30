magic -T /usr/local/share/qflow/tech/osu018/SCN6M_SUBM.10.tech -dnull -noconsole << EOF
drc off
lef read lef/osu018_stdcells.lef
lef read lef/picorv32.lef
lef read lef/picosoc_mem.lef
def read $1
select top cell
save ${cellname}
quit -noprompt
EOF
