class env;
  agent agt;
  scoreboard scb;
  
  mailbox #(trans) mon2scb;
  
  virtual dff_if vif;
  
  function new(virtual dff_if vif);
  this.vif=vif;
  
  mon2scb = new();
  
  agt=new(vif,mon2scb);
  scb=new(mon2scb);
  endfunction
  
  task run;
  fork
  agt.run();
  scb.run();
  join_any
  endtask
endclass

