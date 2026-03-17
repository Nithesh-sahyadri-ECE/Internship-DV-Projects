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

