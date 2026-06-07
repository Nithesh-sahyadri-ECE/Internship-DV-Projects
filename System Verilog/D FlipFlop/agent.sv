
class agent;
  // Component instances
  generator gen;
  driver drv;
  monitor mon;
  
  // Mailboxes for communication
  mailbox #(trans) gen2drv;
  mailbox #(trans) mon2scb;
  
  // Virtual interface connection
  virtual dff_if vif;
  
  // Constructor
  function new(virtual dff_if vif, mailbox #(trans) mon2scb);
    // Connect interface and scoreboard mailbox
    this.vif = vif;
    this.mon2scb = mon2scb;
    
    // Instantiate internal mailbox
    gen2drv = new();
    
    // Instantiate components and pass handles
    gen = new(gen2drv);
    drv = new(vif, gen2drv);
    mon = new(vif, this.mon2scb);
  endfunction
  
  // Simulation execution task
  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
    join_none
  endtask
endclass
