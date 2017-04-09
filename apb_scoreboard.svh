`ifndef APB_SCOREBOARD_SVH
`define APB_SCOREBOARD_SVH
class apb_scoreboard extends uvm_subscriber#(apb_transaction);

	`uvm_component_utils(apb_scoreboard)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	virtual function void write(apb_transaction t);
		//TODO: create actual checker here

		`uvm_info(get_name(), {"APB_TRANSACTION:\n", t.convert2string()}, UVM_LOW)

	endfunction: write

endclass: apb_scoreboard
`endif
