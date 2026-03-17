
module ram_tb;
  reg clk = 0;
  reg rst, we;
  reg [7:0] din;
  reg [3:0] addr;
  wire [7:0] dout;
  integer i;

  // Unit Under Test (UUT) Instantiation
  ram uut(clk, rst, we, din, addr, dout);

  // Clock generation: Toggles every 5 time units (100MHz if 1 unit = 1ns)
  always #5 clk = ~clk;

  initial begin
    // Initialize signals
    rst = 1;
    we = 0;
    addr = 0;
    din = 0;

    // Reset sequence
    #10 rst = 0;
    we = 1;

    // WRITE Loop: Write random data to random addresses 10 times
    for (i = 0; i < 10; i = i + 1) begin
      #10 addr = $random % 10;
      #20 din = $random % 10;
      $display("WRITE : addr=%0d din=%0d", addr, din);
    end

    #10;
    we = 0; // Switch to READ mode

    // READ Loop: Read from random addresses 10 times
    for (i = 0; i < 10; i = i + 1) begin
      #25 addr = $random % 10;
      // Note: Adding a small delay here helps capture the output correctly
      #1 $display("READ : addr=%0d dout=%0d", addr, dout);
    end

    #50 $finish;
  end

endmodule
