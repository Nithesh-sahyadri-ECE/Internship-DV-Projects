
module dual_tb;
  // Port A signals
  reg clk = 0;
  reg rst;
  reg we_a;
  reg [7:0] din_a;
  reg [3:0] addr_a;
  wire [7:0] dout_a;

  // Port B signals
  reg we_b;
  reg [7:0] din_b;
  reg [3:0] addr_b;
  wire [7:0] dout_b;

  integer i;

  // Instantiate the Unit Under Test (UUT)
  dual uut (
    .clk(clk), .rst(rst), 
    .we_a(we_a), .we_b(we_b), 
    .addr_a(addr_a), .addr_b(addr_b), 
    .din_a(din_a), .din_b(din_b), 
    .dout_a(dout_a), .dout_b(dout_b)
  );

  // Clock Generation: Toggles every 5 time units (10 unit period)
  always #5 clk = ~clk;

  initial begin
    // 1. Initialization
    rst = 1;
    we_a = 0; we_b = 0;
    addr_a = 0; addr_b = 0;
    din_a = 0; din_b = 0;

    // 2. Reset and Write Setup
    #10 rst = 0;
    we_b = 1;
    #10 we_a = 1;

    // 3. Randomized Write Loop (10 iterations)
    for (i = 0; i < 10; i = i + 1) begin
      addr_a = $random % 16;
      #10 addr_b = $random % 16;
      #10 din_a = $random % 16;
      #10 din_b = $random % 16;
    end

    // 4. Read Setup
    for (i = 0; i < 10; i = i + 1) begin
      #10 we_a = 0;
      #10 we_b = 0;
      #10 addr_a = $random % 16;
      #10 addr_b = $random % 16;
    #50 $finish;
  end
   initial
   begin
     $monitor("clk=%b rst=%b A: we=%d addr=%d din=%d dout=%d || B: we=%d addr=%d din=%d dout=%d "
              ,clk,rst,we_a,addr_a,din_a,dout_a,we_b,addr_b,din_b,dout_b);
   end
   endmodule


