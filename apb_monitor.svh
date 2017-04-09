`ifndef APB_MONITOR_SVH
`define APB_MONITOR_SVH
class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)

	uvm_analysis_port#(apb_transaction) ap;
	virtual apb_if my_apb_if;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(virtual apb_if)::get(.cntxt(this),.inst_name(""),.field_name("vif"),.value(my_apb_if))) begin
			`uvm_fatal(get_name(), "Monitor cannot find apb_if");
		end

		ap = new(.name("ap"), .parent(this));
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);

		forever begin
			apb_transaction tx;

			@(my_apb_if.slave_cb);
				phase.raise_objection(.obj(this),.description(get_name()));
				tx = apb_transaction::type_id::create(.name("tx"));
				tx.paddr = my_apb_if.paddr;
				//TODO: assign more signals
				@(my_apb_if.slave_cb)
					//tx.prdata = my_apb_if.slave_cb.prdata;
				ap.write(tx);
				phase.drop_objection(.obj(this),.description(get_name()));
		end
	endtask: run_phase
endclass: apb_monitor
`endif
