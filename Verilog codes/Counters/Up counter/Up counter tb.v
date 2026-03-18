
module upcounter_tb;
reg clk, rst;
wire [2:0] count;
integer i;

upcounter uut (clk, rst, count);
always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    #10;
    rst = 0;
    /* for(i=0; i<10; i=i+1)
    begin
        $monitor("clk=%b rst=%b count=%b", clk, rst, count);
        {clk, rst} = i;
        #10;
    end */
    $monitor("clk=%b rst=%b count=%b", clk, rst, count);
    #100;
    $finish;
end

endmodule
