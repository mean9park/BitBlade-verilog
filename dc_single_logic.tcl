set_host_options -max_cores 16

set search_path [list .]
 
set edk_home /home/espanol/libraries/PDKS/SAED32_EDK_12162019/
set io_dir $edk_home/lib/io_std
set pll_dir $edk_home/lib/pll
set stdcell_dir $edk_home/lib/stdcell_hvt

set io_db_dir $io_dir/db_nldm
set pll_db_dir $pll_dir/db_nldm
set stdcell_db_dir $stdcell_dir/db_nldm
 
set synthetic_library dw_foundation.sldb

set link_library "*  $stdcell_db_dir/saed32hvt_ss0p95v125c.db   $pll_db_dir/saed32pll_ss0p95v125c_2p25v.db  $io_db_dir/saed32io_fc_ss0p95v125c_2p25v.db     $synthetic_library"
set target_library "  $stdcell_db_dir/saed32hvt_ss0p95v125c.db  $pll_db_dir/saed32pll_ss0p95v125c_2p25v.db   $io_db_dir/saed32io_fc_ss0p95v125c_2p25v.db  "


sh rm -rf ./WORK
define_design_lib WORK -path WORK

set SOURCE_FILES {
    ./Buffer_32bit.v
}
    # ./bitbrick.v
    # ./signed3bit_MUL.v
    # ./HA.v
    # ./FA.v
    # ./PE.v
    # ./PE_register.v
    # ./PE_shift.v
    # ./PE_adder.v

    # ./MUL3b3b.v
    # ./MUL2b2b.v
    # ./BitBlade_column.v
    # ./ACC_Shift.v
    # ./ACC_register.v
    # ./accumulator.v
    # ./Weight_wire_packing.v
    # ./Weight_MUX_REG.v

analyze -format verilog $SOURCE_FILES -library WORK
elaborate BUF_32bit 

set reports_dir reports
set final_reports_dir final_reports
set design_dir designs

if { ! [ file exists $reports_dir ] } {
	file mkdir $reports_dir
}
if { ! [ file exists $final_reports_dir ] } {
	file mkdir $final_reports_dir
}
if { ! [ file exists $design_dir] } {
	file mkdir $design_dir
}

# set_dont_touch (get_designs MUL2b2b)
# set_dont_touch (get_designs signed_3bit_MUL)
# set_dont_touch (get_designs bitbrick)
# set current_design MUL3b3b
# link

create_clock clk -period 3

ungroup -all -flatten

compile_ultra
#compile

report_design > $design_dir/design_single

report_synthetic > $reports_dir/synthetic_single

report_timing > $final_reports_dir/${current_design}_timing.txt
sh cat $final_reports_dir/${current_design}_timing.txt

report_area > $final_reports_dir/${current_design}_area.txt
sh cat $final_reports_dir/${current_design}_area.txt

report_power > $final_reports_dir/${current_design}_power.txt
sh cat $final_reports_dir/${current_design}_power.txt

write_file -f verilog -hier -output ./output/syn_single.v
write_file -f ddc -hier -output ./output/syn_single.ddc

#exit
