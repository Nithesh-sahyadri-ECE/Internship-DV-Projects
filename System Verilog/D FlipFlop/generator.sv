
class generator;
  mailbox #(trans) mbx;
  
  function new(mailbox #(trans) mbx);
  this.mbx=mbx;
  endfunction
  
  task run();
  repeat(15) begin
  trans t=new();
  assert(t.randomize());
  mbx.put(t);
  #10;
  end
  endtask
endclass
