`ifndef APB_DRIVER_SVH
`define APB_DRIVER_SVH
class apb_driver extends uvm_driver#(apb_transaction);
 
  `uvm_component_utils(apb_driver)

  virtual apb_if my_apb_if;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(virtual apb_if)::get(.cntxt(this), .inst_name(""), .field_name("vif"), .value(my_apb_if))) begin
      `uvm_fatal(get_name(), "Failed to get virtual interface for driver")
	end
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    apb_transaction tx;

	forever begin: driver_run_phase
		seq_item_port.get_next_item(tx);
		phase.raise_objection(.obj(this), .description(get_name()));

		@my_apb_if.master_cb;
			my_apb_if.master_cb.paddr <= tx.paddr;
			my_apb_if.master_cb.pwdata <= tx.pwdata;
			//my_apb_if.master_cb.prdata <= tx.prdata;
			my_apb_if.master_cb.penable <= tx.penable;
			my_apb_if.master_cb.psel <= tx.psel;
			my_apb_if.master_cb.pwrite <= tx.pwrite;

		seq_item_port.item_done();

		@my_apb_if.master_cb;
			phase.drop_objection(.obj(this), .description(get_name()));
    end: driver_run_phase
  endtask: run_phase

endclass: apb_driver
`endif
