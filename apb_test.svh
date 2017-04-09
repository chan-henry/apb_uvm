`ifndef APB_TEST_SVH
`define APB_TEST_SVH
class apb_test extends uvm_test;

	`uvm_component_utils(apb_test)

	apb_env		apb_env_inst;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		apb_env_inst	= apb_env::type_id::create(.name("apb_env_inst"), .parent(this));
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		// Start sequences here
		apb_sequence	apb_seq;

		phase.raise_objection(.obj(this),.description(get_name()));

		apb_seq = apb_sequence::type_id::create("apb_seq");

		assert(apb_seq.randomize());

		`uvm_info("apb_seq", apb_seq.convert2string(), UVM_NONE)

		apb_seq.start(apb_env_inst.apb_agent_inst.apb_sequencer_inst);
		phase.drop_objection(this);
	endtask: run_phase

endclass: apb_test
`endif
