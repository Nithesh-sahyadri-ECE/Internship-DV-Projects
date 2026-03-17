module fifo (clk, rst, wr_en, rd_en, din, dout, full, empty);
  input clk, rst, wr_en, rd_en;
  input [7:0] din;
  output reg [7:0] dout;
  output reg full, empty;

  reg [7:0] mem [3:0];
  reg [1:0] wr_ptr;
  reg [1:0] rd_ptr;
  reg [2:0] count;

  always @(posedge clk or posedge rst)
  begin
    if (rst)
      begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count  <= 0;
        full   <= 0;
        empty  <= 1;
      end
    else
      begin
        // Write Logic
        if (wr_en && !full)
          begin
            mem[wr_ptr] <= din;
            wr_ptr      <= wr_ptr + 1;
            count       <= count + 1;
          end

        // Read Logic
        if (rd_en && !empty)
          begin
            dout   <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            count  <= count - 1;
          end

        // Status Flag Updates
        full  <= (count == 4);
        empty <= (count == 0);
      end
  end
endmodule

TESTBENCH

module fifo_tb;
  reg clk=0, rst, wr_en, rd_en;
  reg [7:0] din;
  wire [7:0] dout;
  wire full, empty;

  // Instantiate the Unit Under Test (UUT)
  fifo uut(clk, rst, wr_en, rd_en, din, dout, full, empty);

  // Clock generation: 10 unit period
  always #5 clk = ~clk;

  initial
  begin
    // Initialize signals
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    din = 0;
    
    #10 rst = 0; // Release reset

    // Write operations
    wr_en = 1;
    din = 8'd45;
    #10 din = 8'd16;
    #10 din = 8'd33;
    #10 din = 8'd63;
    #10 wr_en = 0; // Stop writing

    // Wait and then Read operations
    #10 rd_en = 1;
    #10;
    #10;
    #10;
    #10;
    #10 rd_en = 0; // Stop reading

    #20 $finish; // End simulation
  end

  // Monitor signal changes in the console
  initial
  begin
    $monitor("clk=%d rst=%d wr=%d rd=%d din=%d dout=%d full=%d empty=%d", 
             clk, rst, wr_en, rd_en, din, dout, full, empty);
  end

endmodule
