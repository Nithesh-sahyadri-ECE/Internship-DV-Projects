
module downcounter_tb;

reg clk = 0, rst;
wire [2:0] count;
integer i;

// Instantiate DUT
downcounter uut (clk, rst, count);

// Clock generation
always #5 clk = ~clk;

initial
begin
    rst = 1;
    #10;
    rst = 0;
    #100;

    $finish;
end

// Display values at every clock edge
always @(posedge clk)
begin
    $display("clk=%b rst=%b count=%b", clk, rst, count);
end

endmodule
