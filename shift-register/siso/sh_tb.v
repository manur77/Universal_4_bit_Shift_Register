module sh_tb;

reg clk;
reg reset;
reg serial_in;
wire [3:0] q;

// Instantiate DUT
sh uut (
    .clk(clk),
    .reset(reset),
    .serial_in(serial_in),
    .q(q)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    serial_in = 0;

    #10 reset = 0;

    serial_in = 1; #10;
    serial_in = 0; #10;
    serial_in = 1; #10;
    serial_in = 1; #10;

    #20 $finish;
end

// Monitor values
initial begin
    $monitor("Time=%0t reset=%b serial_in=%b q=%b", 
              $time, reset, serial_in, q);
end

endmodule