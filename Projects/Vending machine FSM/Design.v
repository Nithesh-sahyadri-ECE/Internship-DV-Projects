
module vending_machine_different_product(
    input clk, rst,
    input [3:0] coin,
    input [1:0] sel,
    output reg product,
    output reg [3:0] change
);

parameter A0=0, A5=1, A10=2, A15=3, A20=4, B0=5, B5=6, B10=7, B15=8, B20=9, C0=10, C5=11, C10=12, C15=13, C20=14, C25=15, C30=16;

reg [4:0] state, next_state;

always @(posedge clk or posedge rst)
begin
    if(rst)
        state <= A0;
    else
        state <= next_state;
end

always @(*) begin

    case(state)

        // product A Rs.10
        A0: begin
            if(sel==0) begin
                if(coin==5) next_state = A5;
                else if(coin==10) next_state = A10;
                else next_state = A0;
            end
            else if(sel==1) next_state = B0;
            else if(sel==2) next_state = C0;
        end

        A5: begin
            if(coin==5) next_state = A10;
            else if(coin==10) next_state = A15;
            else next_state = A5;
        end

        A10: next_state = A0;

        A15: next_state = A0;

        A20: next_state = A0;
        //product B Rs.15

        B0:begin
            if(sel==1) begin
                if(coin==5) next_state=B5;
                else if(coin==10) next_state=B10;
                else next_state=B0;
            end
            else if(sel==0) next_state=A0;
            else if(sel==2) next_state=C0;
        end

        B5:begin
            if(coin==5) next_state=B10;
            else if(coin==10) next_state=B15;
            else next_state=B5;
        end

        B10:begin
            if(coin==5) next_state=B15;
            else if(coin==10) next_state=B20;
            else next_state=B10;
        end

        B15: next_state=B0;

        B20: next_state=B0;
        //product C Rs.20
        C0: begin
            if(sel==2) begin
                if(coin==5) next_state=C5;
                else if(coin==10) next_state=C10;
                else next_state=C0;
            end
            else if(sel==1) next_state=B0;
            else if(sel==0) next_state=A0;
        end

        C5: begin
            if(coin==5) next_state=C10;
            else if(coin==10) next_state=C15;
            else next_state=C0;
        end

        C10: begin
            if(coin==5) next_state=C15;
            else if(coin==10) next_state=C20;
            else next_state=C0;
        end
        C15: begin
            if(coin==5) next_state=C20;
            else if(coin==10) next_state=C25;
            else next_state=C0;
        end

        C20: next_state=C0;

        C25: next_state=C0;

        C30: next_state=C0;

        default:next_state=A0;
    endcase
end
always @(*) begin
    product=0;
    change=0;

    case(state)
        //product A
        A10: begin
            product=1;
            change=0;
        end

        A15: begin
            product=1;
            change=5;
        end

        A20: begin
            product=1;
            change=10;
        end

        //product B
        B15: begin
            product=1;
            change=0;
        end

        B20: begin
            product=1;
            change=5;
        end

        //product C
        C20: begin
            product=1;
            change=0;
        end

        C25: begin
            product=1;
            change=5;
        end

        C30: begin
            product=1;
            change=10;
        end
    endcase
end
endmodule

