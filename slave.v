module  slave
(
    input       sys_clk     ,
    input       reset       ,
    input       vaild       ,
    input [7:0] master_data ,
    
    output reg  ready
);

reg     [7:0]   receive_data;

reg    [7:0]    ready_cnt;
always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        ready_cnt <= 1'b0;
    else    if(ready_cnt == 8'd255)
        ready_cnt <= 1'b0;
    else
        ready_cnt <= ready_cnt + 1'b1;
end

////////////////////requirement 1 or 2//////////////////////////////////////

//reg     vaild_d0;
//reg     ready_d0;
//always@(posedge sys_clk or posedge reset)
//begin
//    vaild_d0 <= vaild;
//    ready_d0 <= ready;
//end
//
//always@(posedge sys_clk or posedge reset)
//begin
//    if(reset == 1'b1)
//        ready <= 1'b0;
//    else    if(ready_cnt == 8'd9)
//        ready <= 1'b1;
//    else    if(ready_cnt == 8'd22)
//        ready <= 1'b0;
//    else    if(ready_cnt == 8'd25)
//        ready <= 1'b1;
//    else
//        ready <= ready;
//end
//
//always@(posedge sys_clk or posedge reset)
//begin
//    if(reset == 1'b1)
//        receive_data <= 1'b0;
//    else    if(vaild_d0 & ready_d0)
//        receive_data <= master_data;
//    else
//        receive_data <= receive_data;
//end

/////////////////////requirement 3 or 4////////////////////////////
reg     d0_ready;
reg     ready_d0;
reg     vaild_d0;
reg [7:0]   receive_data_d0;

always@(posedge sys_clk)
begin
    ready_d0 <= ready;
    ready <= d0_ready;
    receive_data <= receive_data_d0;
    vaild_d0 <= vaild;
end

always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        d0_ready <= 1'b0;
    else    if(ready_cnt == 8'd9)
        d0_ready <= 1'b1;
    else    if(ready_cnt == 8'd22)
        d0_ready <= 1'b0;
    else    if(ready_cnt == 8'd26)
        d0_ready <= 1'b1;
    else
        d0_ready <= d0_ready;
end

always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        receive_data_d0 <= 1'b0;
    else    if(vaild_d0 & ready_d0)
        receive_data_d0 <= master_data;
    else
        receive_data_d0 <= receive_data_d0;
end







endmodule