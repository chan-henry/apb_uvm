`timescale 1ns/1ps

interface apb_if( input logic clk );
	logic [31:0]	paddr;
	logic			psel;
	logic			penable;
	logic			pwrite;
	logic [31:0]	prdata;
	logic [31:0]	pwdata;

	clocking master_cb @(posedge clk);
		output	paddr, psel, penable, pwrite, pwdata;
		input	prdata;
	endclocking: master_cb

	clocking slave_cb @(posedge clk);
		output	prdata;
		input	paddr, psel, penable, pwrite, pwdata;
	endclocking: slave_cb

	modport master(input clk, prdata, output paddr, psel, penable, pwrite, pwdata);
	modport slave(input clk, paddr, psel, penable, pwrite, pwdata, output prdata);
endinterface: apb_if

import apb_pkg::*;
import uvm_pkg::*;

module apb_slave_bfm(apb_if.slave slave_if);

	logic [31:0] data;

	always@(posedge slave_if.clk) begin: apb_slave_bfm_main
		randomize(data);
		slave_if.prdata = data;
		//$display("Variable \"slave_if.prdata\" from apb_slave_bfm is: %0h: ", slave_if.prdata);
	end: apb_slave_bfm_main

endmodule: apb_slave_bfm

module top;

	logic clk=1;

	initial begin: clk_gen
		forever #5 clk = ~clk;
	end: clk_gen

	// Instantiate interface
	apb_if my_apb_if(.clk(clk));
	// Instantiate DUT
	apb_slave_bfm apb_slave_bfm_inst(my_apb_if);

	initial begin: start_test
		uvm_config_db#(virtual apb_if)::set(.cntxt(null), .inst_name("uvm_test_top.*"), .field_name("vif"), .value(my_apb_if));
		run_test();
	end: start_test
endmodule: top
