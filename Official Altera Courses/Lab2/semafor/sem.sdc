set_time_format -unit ns

set clkprd 87.8MHz
set tbrd 0.8
set tco_mc_max 6 
set tco_mc_min 2
set tsu_reg 5
set th_reg 2

create_clock -period $clkprd -name clk [get_ports {clk}]
create_clock -period $clkprd -name virt_clk_in
create_clock -period $clkprd -name virt_clk_out

derive_clock_uncertainty

set_input_delay -clock [get_clocks {virt_clk_in}] \
	-max [expr $tco_mc_max + $tbrd] [get_ports {divider[*]}]
set_input_delay -clock [get_clocks {virt_clk_in}] \
	-min [expr $tco_mc_min + $tbrd] [get_ports {divider[*]}]

set_output_delay -clock [get_clocks {virt_clk_out}] \
	-max [expr $tsu_reg + $tbrd] [get_ports {red yellow green}]
set_output_delay -clock [get_clocks {virt_clk_out}] \
	-min [expr -$th_reg + $tbrd] [get_ports {red yellow green}]
	
set_false_path -from [get_ports {clr}] -to [get_clocks {clk}]
