module Reg(clkIn,resetIn,rs1In,rs2In,rdIn,DataIn,WriteIn,Data1Out,Data2Out,portOut);
  input clkIn;          //from outside
  input resetIn;
  input[4:0] rs1In;      //from IMem
  input[4:0] rs2In;      //from IMem
  input[4:0] rdIn;       //from IMem
  input[31:0] DataIn;    //from DataMUX
  input WriteIn;         //from Controller
  output[31:0] Data1Out; //to ALU
  output[31:0] Data2Out; //to ALUMUX,DMem
  output[15:0] portOut;  //to outside:LED
  
  reg[31:0] Reg[31:0];  //general registers
  integer k;
  assign Data1Out=Reg[rs1In];
  assign Data2Out=Reg[rs2In];
  assign portOut=Reg[31][15:0]; //display result through R31
  always @(posedge clkIn) begin
    if (resetIn) begin
      for (k=0;k<32;k=k+1) Reg[k]<=0;
    end
    else if (WriteIn) Reg[rdIn]<=DataIn;
  end
endmodule

