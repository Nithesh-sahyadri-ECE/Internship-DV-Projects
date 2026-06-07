
class driver;
  virtual dff_if vif;
  mailbox #(trans) mbx;
  function new(virtual dff_if vif,mailbox #(trans) mbx);
  this.vif=vif;
  this.mbx=mbx;
  endfunction
  
  task run();
  repeat(15) begin
  trans t;
  mbx.get(t);
  @(posedge vif.clk)
  
  vif.rst=t.rst;
  vif.d =t.d;
  
  #1;
  end
  endtask
  endclass
