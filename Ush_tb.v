`timescale 1ns/1ps

module Ush_tb;

reg clk;
reg reset;
reg load;
reg [3:0] data_in;
wire serial_out;

Ush uut (
    .clk(clk),
    .reset(reset),
    .load(load),
    .data_in(data_in),
    .serial_out(serial_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    load = 0;
    data_in = 4'b0000;

    #10 reset = 0;

    #10 load = 1;
    data_in = 4'b1011;

    #10 load = 0;

    #40;

    #10 load = 1;
    data_in = 4'b1100;

    #10 load = 0;

    #40;

    #20 $finish;
end

initial begin
    $monitor("Time=%0t | reset=%b load=%b data_in=%b serial_out=%b",
              $time, reset, load, data_in, serial_out);
end

endmodule