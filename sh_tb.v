module sh_tb;

reg clk, reset;
reg shift_left, shift_right, load;
reg serial_in;
reg [3:0] data_in;
wire [3:0] data_out;

sh uut (
    .clk(clk),
    .reset(reset),
    .shift_left(shift_left),
    .shift_right(shift_right),
    .load(load),
    .data_in(data_in),
    .serial_in(serial_in),
    .data_out(data_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    
    clk = 0;
    reset = 1;
    shift_left = 0;
    shift_right = 0;
    load = 0;
    serial_in = 0;
    data_in = 4'b0000;

    #10 reset = 0;

    // Load data
    load = 1; data_in = 4'b1011;
    #10 load = 0;

    // Shift left
    shift_left = 1; serial_in = 1;
    #20 shift_left = 0;

    // Shift right
    shift_right = 1; serial_in = 0;
    #20 shift_right = 0;

    #20 $stop;
end

// Monitor (optional but useful)
initial begin
    $monitor("Time=%0t reset=%b load=%b SL=%b SR=%b serial_in=%b data_out=%b",
              $time, reset, load, shift_left, shift_right, serial_in, data_out);
end

endmodule