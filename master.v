module      master
(
    input           sys_clk     ,
    input           reset       ,
    input           ready       ,
    
    output   reg    vaild       ,
    output  reg[7:0]master_data 
);


reg     [7:0]   si_data;
//simulate transmission data
always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        si_data <= 8'd2;
    else    if(si_data == 8'd255)
        si_data <= 8'd2;
    else  
        si_data <= si_data + 1'b1;
end

reg    [7:0]    vaild_cnt;
always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        vaild_cnt <= 1'b0;
    else    if(vaild_cnt == 8'd255)
        vaild_cnt <= 1'b0;
    else
        vaild_cnt <= vaild_cnt + 1'b1;
end

reg [7:0] si_data_d0;
reg [7:0] si_data_d1;
reg [7:0] si_data_d2;
reg [7:0] si_data_d3;
reg [7:0] si_data_d4;
reg [7:0] si_data_d5;
reg [7:0] si_data_d6;

always@(posedge sys_clk)
begin
    si_data_d0 <= si_data;
    si_data_d1 <= si_data_d0;
    si_data_d2 <= si_data_d1;
    si_data_d3 <= si_data_d2;
    si_data_d4 <= si_data_d3;
    si_data_d5 <= si_data_d4;
    si_data_d6 <= si_data_d5;
end

reg     [7:0]   wait_cnt;
always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        wait_cnt <= 1'b0;
    else    if(vaild == 1'b1 && ready == 1'b0)
        wait_cnt <= wait_cnt + 1'b1;
    else    if(vaild == 1'b0 && ready == 1'b0 && wait_cnt != 1'b0)
        wait_cnt <= wait_cnt - 1'b1;
    else
        wait_cnt <= wait_cnt;
    
end

//////////////////requirement1 or 3/////////////////////////////

//always@(posedge sys_clk or posedge reset)
//begin
//    if(reset == 1'b1)
//        vaild <= 1'b0;
//    else    if(vaild_cnt == 8'd10) //the data is vaild at this time
//        vaild <= 1'b1;
//    else    if(vaild_cnt == 8'd15) // the data is invaild
//        vaild <= 1'b0;
//    else    if(vaild_cnt == 8'd20)
//        vaild <= 1'b1;
//    else
//        vaild <= vaild;
//
//end
//
//always@(posedge sys_clk or posedge reset)
//begin
//    if(reset == 1'b1)
//        master_data <= 1'b0;
//    else
//    begin
//        case(wait_cnt)
//        8'd0: master_data <= si_data;
//        8'd1: master_data <= si_data_d1;
//        8'd2: master_data <= si_data_d2;
//        8'd3: master_data <= si_data_d3;
//        8'd4: master_data <= si_data_d4;
//        8'd5: master_data <= si_data_d5;
//        8'd6: master_data <= si_data_d6;
//        default : master_data <= 1'b0; 
//        endcase
//    end
//end


/////////////////requirement2 or 4////////////////////////////////////
reg     vaild_d0;   
always@(posedge sys_clk)
begin
    vaild <= vaild_d0;
end

always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        vaild_d0 <= 1'b0;
    else    if(vaild_cnt == 8'd10) //simulation :the data is vaild at this time
        vaild_d0 <= 1'b1;
    else    if(vaild_cnt == 8'd15) // the data is invaild
        vaild_d0 <= 1'b0;
    else    if(vaild_cnt == 8'd20)
        vaild_d0 <= 1'b1;
    else
        vaild_d0 <= vaild_d0;

end

always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        master_data <= 1'b0;
    else
    begin
        case(wait_cnt)
        8'd0: master_data <= si_data;
        8'd1: master_data <= si_data_d1;
        8'd2: master_data <= si_data_d2;
        8'd3: master_data <= si_data_d3;
        8'd4: master_data <= si_data_d4;
        8'd5: master_data <= si_data_d5;
        8'd6: master_data <= si_data_d6;
        default : master_data <= 1'b0; 
        endcase
    end
end

endmodule