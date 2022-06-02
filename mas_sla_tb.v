module      mas_sla_tb();

reg     sys_clk;
reg     reset;

initial 
begin
    sys_clk = 1'b1;
    reset = 1'b1;
    #200
    reset = 1'b0;
end

always#10   sys_clk = ~sys_clk;


wire        ready;
wire        vaild;
wire   [7:0]master_data;

master      master_inst
(
    .sys_clk    (sys_clk) ,
    .reset      (reset) ,
    .ready      (ready) ,
    
    .vaild      (vaild) ,
    .master_data(master_data) 
);

slave       slave_inst
(
    .sys_clk    (sys_clk) ,
    .reset      (reset) ,
    .vaild      (vaild) ,
    .master_data(master_data) ,
         
    .ready      (ready)
);





endmodule