module      master
(
    input           sys_clk     ,
    input           reset       ,
    input           ready       ,
    
    output   reg    vaild       ,
    output   [7:0]  master_data 
);


reg     [7:0]   si_data;
//simulate transmission data
always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        si_data <= 8'd2;
    else    if(si_data == 8'd255)
        si_data <= 8'd2;
    else    if(ready == 1'b1 && vaild == 1'b1)//反压
        si_data <= si_data + 1'b1;
    else
        si_data <= si_data;
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



//////////////////requirement1 or 3/////////////////////////////
//reg     vaild;
//
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
//assign      master_data = si_data;

/////////////////requirement2 or 4////////////////////////////////////
reg     vaild_d0;   
reg [7:0] master_data;
wire [7:0] master_data_d0;
always@(posedge sys_clk)
begin
    vaild <= vaild_d0;
    master_data <= master_data_d0;
end

always@(posedge sys_clk or posedge reset)
begin
    if(reset == 1'b1)
        vaild_d0 <= 1'b0;
    else    if(vaild_cnt == 8'd10) //the data is vaild at this time
        vaild_d0 <= 1'b1;
    else    if(vaild_cnt == 8'd15) // the data is invaild
        vaild_d0 <= 1'b0;
    else    if(vaild_cnt == 8'd20)
        vaild_d0 <= 1'b1;
    else
        vaild_d0 <= vaild_d0;

end

assign      master_data_d0 = si_data;

endmodule