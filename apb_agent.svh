`ifndef APB_AGENT_SVH
`define APB_AGENT_SVH
class apb_agent extends uvm_agent; 

	`uvm_component_utils(apb_agent)

	uvm_analysis_port#(apb_transaction) ap;

	apb_driver	apb_driver_inst;
	apb_monitor	apb_monitor_inst;
	apb_sequencer	apb_sequencer_inst;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		apb_driver_inst		= apb_driver::type_id::create("apb_driver_inst", this);
		apb_monitor_inst	= apb_monitor::type_id::create("apb_monitor_inst", this);
		apb_sequencer_inst	= apb_sequencer::type_id::create("apb_sequencer_inst", this);

		ap = new(.name("ap"),.parent(this));
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		apb_driver_inst.seq_item_port.connect(apb_sequencer_inst.seq_item_export);
		uvm_report_info(get_name(), ": connect_phase, driver and sequencer connected");

		apb_monitor_inst.ap.connect(ap);
	endfunction: connect_phase

endclass: apb_agent
`endif
