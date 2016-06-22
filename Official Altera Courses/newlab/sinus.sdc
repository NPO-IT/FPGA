set_time_format -unit ns
derive_clock_uncertainty
create_clock -period 50MHz -name {clk} [get_ports {inclk}]
derive_pll_clocks
set_false_path -from [get_ports {phase*}] -to [get_clocks {oscdiv|altpll_component|auto_generated|pll1|clk[0]}] 
set_output_delay -clock [get_clocks {clk}] -max 10.0 [get_ports {fout*}]
set_output_delay -clock [get_clocks {clk}] -min -2.0 [get_ports {fout*}]
