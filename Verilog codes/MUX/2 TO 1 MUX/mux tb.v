
module tb_mux2to1;

reg I0, I1, S;
wire Y;

// Instantiate MUX
mux2to1 uut (
    .I0(I0),
    .I1(I1),
    .S(S),
    .Y(Y)
);

initial begin
    $display("I0 I1 S | Y");
    $display("-----------");

    I0=0; I1=0; S=0; #10;
    $display("%b  %b  %b | %b", I0, I1, S, Y);

    I0=0; I1=1; S=0; #10;
    $display("%b  %b  %b | %b", I0, I1, S, Y);

    I0=1; I1=0; S=1; #10;
    $display("%b  %b  %b | %b", I0, I1, S, Y);

    I0=1; I1=1; S=1; #10;
    $display("%b  %b  %b | %b", I0, I1, S, Y);

    $finish;
end

endmodule
