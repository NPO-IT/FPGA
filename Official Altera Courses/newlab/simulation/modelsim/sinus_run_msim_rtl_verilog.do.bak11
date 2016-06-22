transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Altera/Courses/newlab {D:/Altera/Courses/newlab/buttons.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/newlab {D:/Altera/Courses/newlab/accumulator.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/newlab {D:/Altera/Courses/newlab/LUT.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/newlab {D:/Altera/Courses/newlab/sinus.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/newlab {D:/Altera/Courses/newlab/ds_DAC.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/newlab {D:/Altera/Courses/newlab/pll.v}
vlog -vlog01compat -work work +incdir+D:/Altera/Courses/newlab/db {D:/Altera/Courses/newlab/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+D:/Altera/Courses/newlab {D:/Altera/Courses/newlab/sinus_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  sinus_tb

do D:/Altera/Courses/newlab/simulation/modelsim/wave.do
