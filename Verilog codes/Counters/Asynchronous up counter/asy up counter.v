
module upcounter (clk, rst, count);

input clk, rst;
output reg [2:0] count;

always @(posedge clk)
begin
    if (rst)
        count <= 3'b000;   // Reset to 0
    else
        count <= count + 1; // Increment
end

endmodule
