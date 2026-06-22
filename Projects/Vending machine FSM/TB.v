
module vending_machine_different_product_tb;
    reg clk,rst;
    reg [3:0] coin;
    reg [1:0] sel;
    wire product;
    wire [3:0] change;
    
    vending_machine_different_product dut(clk,rst,coin,sel,product,change);
    
    always #5 clk=~clk;
    
    initial
    begin
        clk=0;rst=1;
        #10 rst=0;
        
        $monitor("time=%0t clk=%b rst=%b coin=%0d sel=%0d product=%b,change=%0d",$time,clk,rst,coin,sel,product,change);
        sel=0;
        #5 coin=5;
        #10 coin=10;
        #10 coin=10;
        #10 coin=10;
        sel=2;
        #10 coin=5;
        #10 coin=10;
        #10 coin=10;
        #10 sel=0;
        #10 coin=5;
        #20 coin=10;
        #10 sel=1;
        #10 coin=10;
        #10 coin=10;
        
        #80;
        $finish;
    end
    
endmodule
