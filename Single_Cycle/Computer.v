module Computer(clk,rstn,sw_i,disp_seg_o,disp_an_o);
  input clk; //from outside
  input rstn; //from outside
  input [15:0] sw_i;
  reg[15:0] led_o; //to outside
  output [7:0]disp_seg_o;
  output [7:0]disp_an_o;
  
  wire clkIn;
  wire resetIn;
  wire [15:0] portOut;
  reg[31:0] clkdiv;
     wire clk1;
     always@(posedge clk or negedge rstn) begin
        if(~rstn)
            clkdiv <=0 ;
        else 
            clkdiv <= clkdiv + 1'b1;
     end
     assign clkIn=(sw_i[14]) ? clk : clkdiv[24];
  //module PC(clkIn,resetIn,AddrIn,AddrOut);
 
  wire[31:0] AddrMUX_AddrOut; 
  wire[31:0] PC_AddrOut;
  PC myPC(clkIn,~rstn,AddrMUX_AddrOut,PC_AddrOut);

  //module IMem(AddrIn,InsOut);
  wire[31:0] IMem_InsOut;
  IMem myIMem(PC_AddrOut,IMem_InsOut);

  //module Controller(opcodeIn,ctrSignalsOut);
  wire[11:0] Controller_ctrSignalsOut;
  Controller myController (IMem_InsOut[4:0],Controller_ctrSignalsOut);

  //module Reg(clkIn,resetIn,rs1In,rs2In,rdIn,DataIn,WriteIn,
  //Data1Out,Data2Out,portOut);
  wire[31:0] DataMUX_DataOut;
  wire[31:0] Reg_Data1Out;
  wire[31:0] Reg_Data2Out;
  Reg myReg(clkIn,~rstn,IMem_InsOut[19:15],IMem_InsOut[24:20],IMem_InsOut[11:7],DataMUX_DataOut,Controller_ctrSignalsOut[11],Reg_Data1Out,Reg_Data2Out,portOut);

  //module ImmGen(InsIn,Imm32Out);
  wire[31:0] ImmGen_Imm32Out;
  ImmGen myImmGen(IMem_InsOut,ImmGen_Imm32Out);

  //module ALUMUX(DataIn,Imm32In,SelectorIn,DataOut);
  wire[31:0] ALUMUX_DataOut;
  ALUMUX myALUMUX(Reg_Data2Out,ImmGen_Imm32Out,Controller_ctrSignalsOut[0],ALUMUX_DataOut);

  //module ALU(Data1In,Data2In,OperatorIn,LessOut,ZeroOut,ResultOut);
  wire ALU_LessOut;
  wire ALU_ZeroOut;
  wire[31:0] ALU_ResultOut;
  ALU myALU(Reg_Data1Out,ALUMUX_DataOut,Controller_ctrSignalsOut[3:1],ALU_LessOut,ALU_ZeroOut,ALU_ResultOut);

  //module PCRelAddrAdder(OffsetIn,AddrIn,AddrOut);
  wire[31:0] PCRelAddrAdder_AddrOut;
  PCRelAddrAdder myPCRelAddrAdder(ImmGen_Imm32Out,PC_AddrOut,PCRelAddrAdder_AddrOut);

  //module SeqAddrAdder(AddrIn,AddrOut);
  wire[31:0] SeqAddrAdder_AddrOut;
  SeqAddrAdder mySeqAddrAdder(PC_AddrOut,SeqAddrAdder_AddrOut);


  //module AddrMUX(LessIn,ZeroIn,RegRelAddrIn,PCRelAddrIn,SeqAddrIn,SelectorIn,AddrOut);
  wire[31:0]PC_AddrIn;
  assign PC_AddrIn=AddrMUX_AddrOut;
  AddrMUX myAddrMUX(ALU_LessOut,ALU_ZeroOut,ALU_ResultOut,PCRelAddrAdder_AddrOut,SeqAddrAdder_AddrOut,Controller_ctrSignalsOut[6:4],AddrMUX_AddrOut);


  //module DMem(clkIn,AddrIn,DataIn,ReadIn,WriteIn,DataOut);
  wire[31:0] DMem_DataOut;
  DMem myDMem(clkIn,~rstn,ALU_ResultOut,Reg_Data2Out,Controller_ctrSignalsOut[8],Controller_ctrSignalsOut[7],DMem_DataOut);

  //module DataMUX(ResultIn,Imm32In,DataIn,SeqAddrIn,SelectorIn,DataOut); 
  DataMUX myDataMUX(ALU_ResultOut,ImmGen_Imm32Out,DMem_DataOut,SeqAddrAdder_AddrOut,Controller_ctrSignalsOut[10:9],DataMUX_DataOut);

  always@(*) begin
  if( sw_i[15]==1'b0 ) begin
  led_o = PC_AddrOut;
  end
  else begin
  led_o = portOut;
  end
  end
  
   seg7x16 u(.clk(clk),.rstn(rstn),.i_data(led_o),.o_seg(disp_seg_o),.o_sel(disp_an_o));
endmodule