`ifndef APB_SEQUENCES_SVH
`define APB_SEQUENCES_SVH
class apb_sequence extends uvm_sequence#(apb_transaction);

	`uvm_object_utils(apb_sequence)

	function new(string name="");
		super.new(name);
	endfunction: new

	task body();
		apb_transaction tx; // Create transaction handle

		repeat(10) begin: tx_create_loop
			tx = apb_transaction::type_id::create("tx", .contxt(get_full_name()));
			start_item(tx);
			assert(tx.randomize());
			finish_item(tx);
		end: tx_create_loop
	endtask: body
endclass: apb_sequence
`endif
