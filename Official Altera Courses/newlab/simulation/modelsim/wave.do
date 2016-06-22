onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /buttons_tb/clk
add wave -noupdate /buttons_tb/clr
add wave -noupdate /buttons_tb/btnUP
add wave -noupdate /buttons_tb/btnDN
add wave -noupdate /buttons_tb/result
add wave -noupdate /buttons_tb/buttons_tb/clkDetect
add wave -noupdate /buttons_tb/buttons_tb/cntClk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {145817739050 ps} {145817740050 ps}
run -all
