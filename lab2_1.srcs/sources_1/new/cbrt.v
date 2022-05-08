module cbrt(
    input clk_i,   
    input rst_i,   
    input [7:0] x_bi,
    input start_i,
    output busy_o,
    output reg [7:0] answer
    );
    
    reg [7:0] mul_a;
    reg [7:0] mul_b;
    reg mul_start = 0;
    wire mul_busy;
    wire [15:0] mul_result;
    
    mul mul_1(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .a_bi(mul_a),
        .b_bi(mul_b),
        .start_i(mul_start),
        .busy_o(mul_busy),
        .y_bo(mul_result)
    );
    localparam IDLE = 1'b0;
    localparam WORK = 1'b1;
    reg state = 0;
    reg signed[8:0]s = 0;
    reg [8:0]y = 0;
    reg [7:0]b = 0;
    reg [7:0]x = 0;
    reg step_1 = 0;
    reg step_2 = 0;
    reg step_2_starts = 0;
    reg step_3_starts = 0;
    reg step_3_logic_part = 0;
    wire [7:0]b_logic_scheme;
    assign b_logic_scheme = (mul_result + 1) << s;
    assign busy_o = state ;
    always @(posedge clk_i)
         if(rst_i) begin        
             state <= IDLE ;
         end else begin
            case(state)
                IDLE: 
                    if (start_i) begin    
                        state <= WORK;
                        y <= 0;
                        b <= 0;
                        x <= x_bi;
                        s <= 6;
                        step_1 <= 0;
                        step_2 <= 0;
                    end
                WORK:
                    if(s[8] == 1) begin
                        state <= IDLE ;
                        answer <= y;
                    end else if(!step_1) begin
                        y <= y<<1;
                        step_1 <= 1;
                    end else if(!step_2) begin
                        if(!mul_busy) begin
                            if(step_2_starts) begin
                                b <= mul_result;
                                step_2 <= 1;
                                step_2_starts <= 0;
                            end else if(!mul_start)begin
                                mul_a <= y;
                                mul_b <= y + 1;
                                mul_start <= 1;
                            end
                        end else 
                        if(mul_start) begin
                            mul_start <= 0;
                            step_2_starts <= 1;
                        end
                    end else begin
                        if(!mul_busy) begin
                            if(step_3_starts) begin
                                if(!step_3_logic_part) begin
                                    b <= b_logic_scheme;
                                    step_3_logic_part <= 1;
                                end else  begin
                                    if(x >= b) begin
                                        x <= x - b;
                                        y <= y + 1;
                                    end
                                    s <= s - 3;
                                    step_1 <= 0;
                                    step_2 <= 0;
                                    step_3_starts <= 0;
                                    step_3_logic_part <= 0;
                                end
                            end else if(!mul_start)begin
                                mul_a <= b;
                                mul_b <= 3;
                                mul_start <= 1;
                            end else
                            if(mul_start) begin
                                mul_start <= 0;
                                step_3_starts <= 1;
                            end
                        end
                    end
            endcase
         end    
endmodule
