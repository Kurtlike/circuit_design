`timescale 1ns / 1ps

module main_funk(
    input clk_i,
    input rst_i,
    input [7:0] a,
    input [7:0] b,
    input start_i,
    output busy_o,
    output reg [8:0] answer
    );
   
    //cube
    reg cube_starts = 0;
    reg [7:0]cube_input;
    reg cube_rst = 0;
    reg cube_start = 0;
    wire cube_busy;
    wire [7:0]cube_result;
    cbrt cube(
        .clk_i(clk_i),
        .rst_i(cube_rst),
        .x_bi(cube_input),
        .start_i(cube_start),
        .busy_o(cube_busy),
        .answer(cube_result)
    );
    reg is_cube_ready = 0;
    reg is_cube_start = 0;
    
  
    reg [7:0] sqrt_m;
    reg [7:0] sqrt_y;
    reg [7:0] sqrt_b;
    reg [7:0] sqrt_x;
    reg sqrt_ready = 0;
    reg sqrt_logic_part = 0;
    reg state = 0;
    wire [7:0]sqrt_b_logic_scheme;
    wire [7:0]sqrt_x_logic_scheme;
    wire [7:0]sqrt_y_logic_scheme;
    localparam IDLE = 1'b0;
    localparam WORK = 1'b1;
    assign sqrt_b_logic_scheme = sqrt_y |  sqrt_m;
    assign sqrt_x_logic_scheme = sqrt_x - sqrt_b;
    assign sqrt_y_logic_scheme = sqrt_y | sqrt_m;
    assign busy_o = state ;
    
    always @(posedge clk_i)
         if(rst_i) begin    
             answer <= 0 ;     
             state <= IDLE ;
         end else begin
            case(state)
                IDLE: 
                    if (start_i) begin    
                        state <= WORK; 
                    
                        sqrt_m <= 1 << 6;
                        sqrt_y <= 0;
                        sqrt_b <= 0;
                        sqrt_x <= b;
                        sqrt_ready <=0;
                        is_cube_ready <= 0;
                  
                    end
                WORK:     
                     begin
                        if(is_cube_ready && sqrt_ready) begin
                             state <= IDLE;
                             answer <= cube_result + sqrt_y;
                        end
                        if(!is_cube_ready) begin
                            if(!cube_busy) begin
                                if(cube_starts) begin
                                    cube_starts <= 0;
                                    is_cube_ready <= 1;
                                end else if(!cube_start)begin
                                    cube_input <= a;
                                    cube_start <= 1; 
                                end                             
                            end else begin 
                                if(cube_start) begin
                                    cube_starts <= 1;
                                    cube_start <= 0; 
                                end
                            end 
                        end else begin
                            if(sqrt_m == 0) begin
                                sqrt_ready <= 1;
                            end else begin
                                if(!sqrt_logic_part) begin
                                    sqrt_b <= sqrt_b_logic_scheme;
                                    sqrt_y <= sqrt_y >> 1;
                                    sqrt_logic_part <= 1;
                                end else begin
                                    if(sqrt_x >= sqrt_b) begin
                                        sqrt_x <= sqrt_x_logic_scheme;
                                        sqrt_y <= sqrt_y_logic_scheme;     
                                    end       
                                    sqrt_m <= sqrt_m >> 2; 
                                    sqrt_logic_part <= 0;
                                end
                            end
                        end  
                     end       
            endcase
    end            
endmodule
