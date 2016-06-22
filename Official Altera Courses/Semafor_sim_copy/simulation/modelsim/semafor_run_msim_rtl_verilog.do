transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Altera/Courses/Semafor_sim_copy {D:/Altera/Courses/Semafor_sim_copy/dec.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/Semafor_sim_copy {D:/Altera/Courses/Semafor_sim_copy/periodrom.v}

vlog -vlog01compat -work work +incdir+D:/Altera/Courses/Semafor_sim_copy {D:/Altera/Courses/Semafor_sim_copy/semafor_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  semafor_tb

do D:/Altera/Courses/Semafor_sim_copy/simulation/modelsim/wave.do
