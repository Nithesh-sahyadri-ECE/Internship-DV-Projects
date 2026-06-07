
class monitor;
  virtual dff_if vif;
  mailbox #(trans) mbx;
  function new(virtual dff_if vif,mailbox #(trans) mbx);
  this.vif=vif;
  this.mbx=mbx;
  endfunction
  task run();
  repeat(15) begin
  trans t=new();
  #1;
  @(posedge vif.clk)
  t.rst=vif.rst;
  t.d=vif.d;
  t.q=vif.q;
  
  mbx.put(t);
  end
  endtask
endclass
