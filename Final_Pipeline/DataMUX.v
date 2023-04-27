module DataMUX(ResultIn,Imm32In,DataIn,AddrIn,SelectorIn,DataOut);
  input[31:0] ResultIn;     //from ALU：运算类指令
  input[31:0] Imm32In;      //from ImmGen：指令lui
  input[31:0] DataIn;       //from DMem：指令lw
  input[31:0] AddrIn;       //from PCPlus1Adder：指令jal/jalr
  input[1:0] SelectorIn;    //from Controller
  output reg[31:0] DataOut; //to Reg

  always @(*) begin
    if (SelectorIn==0) DataOut<=ResultIn;
    else if (SelectorIn==1) DataOut<=Imm32In;
    else if (SelectorIn==2) DataOut<=DataIn;
    else DataOut<=AddrIn;
  end
endmodule

