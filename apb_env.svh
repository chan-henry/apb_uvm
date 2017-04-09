`ifndef APB_ENV_SVH
`define APB_ENV_SVH
class apb_env extends uvm_env;

	`uvm_component_utils(apb_env)

	apb_agent		apb_agent_inst;
	apb_scoreboard	apb_scoreboard_inst;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		apb_agent_inst	= apb_agent::type_id::create("apb_agent_inst", this);
		apb_scoreboard_inst = apb_scoreboard::type_id::create("apb_scoreboard_inst", this);
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		apb_agent_inst.ap.connect(apb_scoreboard_inst.analysis_export);
	endfunction: connect_phase

endclass: apb_env
`endif
