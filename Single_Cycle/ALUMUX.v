module ALUMUX(DataIn,Imm32In,SelectorIn,DataOut);
  input[31:0] DataIn; //from Reg
  input[31:0] Imm32In;    //from ImmGen
  input SelectorIn;       //from Controller
  output[31:0] DataOut;   //to ALU
  assign DataOut=SelectorIn?DataIn:Imm32In;
endmodule

