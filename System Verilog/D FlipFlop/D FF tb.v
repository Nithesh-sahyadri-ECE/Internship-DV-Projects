
module tb;

dff_if vif();

dff dut(
  .clk(vif.clk),
  .rst(vif.rst),
  .d(vif.d),
  .q(vif.q));

initial begin
vif.clk=0;
forever #5 vif.clk=~vif.clk;
end

env e;
initial begin
e=new(vif);
e.run();
#200 $finish;
end
endmodule
