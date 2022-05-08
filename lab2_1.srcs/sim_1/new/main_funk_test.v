`timescale 10ns / 1ps

module main_funk_test;
    reg clk_i;
    reg rst_i = 0;
    reg [7:0] a;
    reg [7:0] b;
    reg start_i;
    wire busy_o;
    wire [7:0] result;
    
    main_funk main(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .a(a),
        .b(b),
        .start_i(start_i),
        .busy_o(busy_o),
        .answer(result)
    );
    reg[7:0] expected [0:10];
  
    integer i;
    initial begin
    
        expected[0] = 0;
        expected[1] = 7;
        expected[2] = 10;
        expected[3] = 12;
        expected[4] = 14;
        expected[5] = 16;
        expected[6] = 17;
        expected[7] = 18;
        expected[8] = 19;
        expected[9] = 21;
        expected[10] = 21;
        
        for(i = 0; i < 11; i = i + 1) begin
                a = i * 25;
                b = i * 25;
                start_i = 1;
                clk_i = 1;
                #1;
                clk_i = 0;
                #1;
                clk_i = 1;
                #1;
                clk_i = 0;
                start_i = 0;
                #1;
                while(busy_o) begin
                    clk_i = 1;
                    if(i == 5) rst_i = 1;
                    #1;
                    clk_i = 0;
                    if(i == 5) rst_i = 0;
                    #1;
                end
                if(expected[i] != result)begin
                     $display("fail");
                end
                $display ("a = %d, b = %d, result = %d, expected = %d", a, b, result, expected[i]);
            end
        $stop;
    end
endmodule