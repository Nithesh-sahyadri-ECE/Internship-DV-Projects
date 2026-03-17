
module dual_port_ram (
    input clk, rst, we_a,
    input [3:0] addr_a,
    input [7:0] din_a,
    output reg [7:0] dout_a,
    
    input we_b,
    input [3:0] addr_b,
    input [7:0] din_b,
    output reg [7:0] dout_b
);

    // Memory array: 16 locations, each 8-bits wide
    reg [7:0] mem [0:15];

    always @(posedge clk) begin
        if (rst) begin
            // Synchronous reset for output registers
            dout_a <= 0;
            dout_b <= 0;
        end
        else begin
            // Port A Logic
            if (we_a)
                mem[addr_a] <= din_a; // Write operation
            else
                dout_a <= mem[addr_a]; // Read operation

            // Port B Logic
            if (we_b)
                mem[addr_b] <= din_b; // Write operation
            else
                dout_b <= mem[addr_b]; // Read operation
        end
    end

endmodule
