
module ram(clk, rst, we, din, addr, dout);
  input clk, rst, we;
  input [7:0] din;
  input [3:0] addr;
  output reg [7:0] dout;

  reg [7:0] mem[0:15];

  always @(posedge clk)
  begin
    if(rst)
    begin
      dout <= 8'd0;
    end
    else
    begin
      if(we)
        mem[addr] <= din;
      else
        dout <= mem[addr];
    end
  end
endmodule
