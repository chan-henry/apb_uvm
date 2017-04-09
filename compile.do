vlib apb_uvm

vlog -work apb_uvm +incdir+"$aldec/vlib/uvm-1.2/src" -l uvm_1_2 apb_pkg.sv top.sv

do sim.do
