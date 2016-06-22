transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {semafor_min_1200mv_-40c_fast.vo}

vlog -vlog01compat -work work +incdir+D:/Altera/Courses/Semafor_sim {D:/Altera/Courses/Semafor_sim/semafor_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  semafor_tb

do D:/Altera/Courses/Semafor_sim/simulation/modelsim/wave.do
