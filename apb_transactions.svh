`ifndef TRANSACTIONS_SVH
`define TRANSACTIONS_SVH
class apb_transaction extends uvm_sequence_item;

	`uvm_object_utils(apb_transaction)

	rand int unsigned pwdata, paddr, prdata;
	rand bit penable, psel, pwrite;

/*
	constraint constrain_addr{
		paddr >= 0;
		paddr <= 32'hFFFF_FFFF;
	}
	constraint constrain_data{
		pwdata >= 0;
		pwdata <= 32'hFFFF_FFFF;
		prdata >= 0;
		prdata <= 32'hFFFF_FFFF;
	}
*/

	function new(string name="");
		super.new(name);
	endfunction: new

	function string convert2string();
		string s = super.convert2string();
		s = {s, $sformatf("\n paddr: %0h, pwdata: %0h, prdata: %0h", paddr, pwdata, prdata)};
		s = {s, $sformatf("\n penable: %0b, psel: %0b, pwrite: %0b", penable, psel, pwrite)};
		return s;
	endfunction: convert2string

endclass: apb_transaction
`endif
