`timescale 1ns / 1ps

module sqrt(
    input clk_i,   
    input rst_i,   
    input [7:0] x_bi,
    input start_i,
    output busy_o,
    output reg [7:0] answer
);
    reg [7:0] m;
    reg [7:0] y;
    reg [7:0] b;
    reg [7:0] x;
    reg state = 0;
    localparam IDLE = 1'b0;
    localparam WORK = 1'b1;
    assign busy_o = state ;
    
    always @(posedge clk_i)
         if(rst_i) begin    
             m <= 1 << 6;
             b <= 0;
             y <= 0;            
             answer <= 0 ;     
             state <= IDLE ;
         end else begin
            case(state)
                IDLE: 
                    if (start_i) begin    
                        state <= WORK;    
                        m <= 1 << 6;
                        answer <= 0;
                        b <= 0;
                        y <= 0;
                        x <= x_bi;  
                    end
                WORK:     
                     begin
                        if(m == 0) begin
                            state <= IDLE ;
                            answer <= y;
                        end else begin
                            b = y | m;
                            y = y >> 1;
                            if(x >= b) begin
                                x = x - b;
                                y = y | m;     
                            end       
                            m = m >> 2; 
                        end
                     end       
        endcase
    end            
endmodule
