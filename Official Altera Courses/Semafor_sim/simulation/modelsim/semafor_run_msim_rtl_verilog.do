transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Altera/Courses/Semafor_sim {D:/Altera/Courses/Semafor_sim/semafor.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/Semafor_sim {D:/Altera/Courses/Semafor_sim/dec.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/Semafor_sim {D:/Altera/Courses/Semafor_sim/comm.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/Semafor_sim {D:/Altera/Courses/Semafor_sim/periodrom.v}

vlog -vlog01compat -work work +incdir+D:/Altera/Courses/Semafor_sim {D:/Altera/Courses/Semafor_sim/semafor_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  semafor_tb

do D:/Altera/Courses/Semafor_sim/simulation/modelsim/wave.do