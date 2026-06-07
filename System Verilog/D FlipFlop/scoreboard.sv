
class scoreboard;
  mailbox #(trans) mbx;
  function new(mailbox #(trans) mbx);
  this.mbx=mbx;
  endfunction
  
  task run();
  trans t;
  bit exp;
  
  repeat(15) begin
  mbx.get(t);
  if(t.rst)
  exp=0;
  else
  exp=t.d;
  
  if(exp==t.q)
  $display("pass: rst=%0d  d=%0d  q=%0d || exp=%0d",t.rst,t.d,t.q,exp);
  else
  $display("fail: rst=%0d  d=%0d  q!=%0d || exp=%0d",t.rst,t.d,t.q,exp);
  end
  endtask
endclass
