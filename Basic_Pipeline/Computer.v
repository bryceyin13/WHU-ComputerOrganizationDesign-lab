module Computer(clk,rstn,sw_i,disp_seg_o,disp_an_o);
  input clk; //from outside
  input rstn; //from outside
  input [15:0] sw_i;
  reg[15:0] led_o; //to outside
  output [7:0]disp_seg_o;
  output [7:0]disp_an_o;
  
  wire clkIn;
  reg[31:0] clkdiv;
     wire clk1;
     always@(posedge clk or negedge rstn) begin
        if(~rstn)
            clkdiv <=0 ;
        else 
            clkdiv <= clkdiv + 1'b1;
     end
     assign clkIn=(sw_i[14]) ? clk : clkdiv[25];
     
  //module PC(clkIn,resetIn,AddrIn,AddrOut);
 
  wire[31:0] AddrMUX_AddrOut; 
  wire[31:0] PC_AddrOut;
  PC myPC(clkIn,rstn,AddrMUX_AddrOut,PC_AddrOut);

  //module IMem(AddrIn,InsOut);
  wire[31:0] IMem_InsOut;
  IMem myIMem(PC_AddrOut,IMem_InsOut);

  //module IF/ID Register
  wire [31:0] IFID_AddrOut;
  wire [31:0] IFID_InsOut;
  IFIDReg IFIDRegister(clkIn,rstn,PC_AddrOut,IFID_AddrOut,IMem_InsOut,IFID_InsOut);
 
 //module SeqAddrAdder(AddrIn,AddrOut);
  wire[31:0] SeqAddrAdder_AddrOut;
  SeqAddrAdder mySeqAddrAdder(PC_AddrOut,SeqAddrAdder_AddrOut);
  
  //module Controller(opcodeIn,ctrSignalsOut);
  wire[11:0] Controller_ctrSignalsOut;
  Controller myController (IFID_InsOut[4:0],Controller_ctrSignalsOut);

  //module Reg(clkIn,resetIn,rs1In,rs2In,rdIn,DataIn,WriteIn,
  //Data1Out,Data2Out,portOut);
  wire [11:0] MEMWB_ctrSignalsOut;
  wire [4:0] MEMWB_rdOut;
  wire [31:0] DataMUX_DataOut;
  wire [31:0] Reg_Data1Out;
  wire [31:0] Reg_Data2Out;
  wire [15:0] portOut;
  Reg myReg(clkIn,rstn,IFID_InsOut[19:15],IFID_InsOut[24:20],MEMWB_rdOut,DataMUX_DataOut,MEMWB_ctrSignalsOut[11],Reg_Data1Out,Reg_Data2Out,portOut);

  //module ImmGen(InsIn,Imm32Out);
  wire[31:0] ImmGen_Imm32Out;
  ImmGen myImmGen(IFID_InsOut,ImmGen_Imm32Out);

  //module ID/EX Register
  wire[4:0] IDEX_rdOut;
  wire[31:0] IDEX_AddrOut;
  wire[31:0] IDEX_Imm32Out;
  wire[31:0] IDEX_Data1Out;
  wire[31:0] IDEX_Data2Out;
  wire[11:0] IDEX_ctrSignalsOut;
  IDEXReg IDEXRegister(clkIn,rstn,IFID_InsOut[11:7],IFID_AddrOut,ImmGen_Imm32Out,Reg_Data1Out,Reg_Data2Out,IDEX_rdOut,IDEX_AddrOut,IDEX_Imm32Out,IDEX_Data1Out,IDEX_Data2Out,Controller_ctrSignalsOut,IDEX_ctrSignalsOut);

  //module ALUMUX(DataIn,Imm32In,SelectorIn,DataOut);
  wire[31:0] ALUMUX_DataOut;
  ALUMUX myALUMUX(IDEX_Data2Out,IDEX_Imm32Out,IDEX_ctrSignalsOut[0],ALUMUX_DataOut);

  //module ALU(Data1In,Data2In,OperatorIn,LessOut,ZeroOut,ResultOut);
  wire ALU_LessOut;
  wire ALU_ZeroOut;
  wire[31:0] ALU_ResultOut;
  ALU myALU(IDEX_Data1Out,ALUMUX_DataOut,IDEX_ctrSignalsOut[3:1],ALU_LessOut,ALU_ZeroOut,ALU_ResultOut);

  //module PCRelAddrAdder(OffsetIn,AddrIn,AddrOut);
  wire[31:0] PCRelAddrAdder_AddrOut;
  PCRelAddrAdder myPCRelAddrAdder(IDEX_Imm32Out,IDEX_AddrOut,PCRelAddrAdder_AddrOut);

  //module retAddrAdder
  wire[31:0] retAddrAdder_retAddrOut;
  retAddrAdder myretAddrAdder(IDEX_AddrOut,retAddrAdder_retAddrOut);

  //module EX/MEM Register
  wire[11:0] EXMEM_ctrSignalsOut;
  wire EXMEM_LessOut;
  wire EXMEM_ZeroOut;
  wire [31:0] EXMEM_ResultOut;
  wire [31:0] EXMEM_Data2Out;
  wire [31:0] EXMEM_Imm32Out;
  wire [31:0] EXMEM_AddrOut;
  wire [31:0] EXMEM_retAddrOut;
  wire [4:0] EXMEM_rdOut;
  EXMEMReg EXMEMRegister(clkIn,rstn,IDEX_rdOut,PCRelAddrAdder_AddrOut,retAddrAdder_retAddrOut,IDEX_Imm32Out,IDEX_Data2Out,ALU_LessOut,ALU_ZeroOut,ALU_ResultOut,IDEX_ctrSignalsOut,
  EXMEM_rdOut,EXMEM_AddrOut,EXMEM_retAddrOut,EXMEM_Imm32Out,EXMEM_Data2Out,EXMEM_LessOut,EXMEM_ZeroOut,EXMEM_ResultOut,EXMEM_ctrSignalsOut);
  
  //module AddrMUX(LessIn,ZeroIn,RegRelAddrIn,PCRelAddrIn,SeqAddrIn,SelectorIn,AddrOut);
  /*wire[31:0] PC_AddrIn;
  assign PC_AddrIn=AddrMUX_AddrOut;*/
  AddrMUX myAddrMUX(EXMEM_LessOut,EXMEM_ZeroOut,EXMEM_ResultOut,EXMEM_AddrOut,SeqAddrAdder_AddrOut,EXMEM_ctrSignalsOut[6:4],AddrMUX_AddrOut);


  //module DMem(clkIn,AddrIn,DataIn,ReadIn,WriteIn,DataOut);
  wire[31:0] DMem_DataOut;
  DMem myDMem(clkIn,rstn,EXMEM_ResultOut,EXMEM_Data2Out,EXMEM_ctrSignalsOut[8],EXMEM_ctrSignalsOut[7],DMem_DataOut);

  //module MEMWB Register
  wire [31:0] MEMWB_ResultOut;
  wire [31:0] MEMWB_Data2Out;
  wire [31:0] MEMWB_Imm32Out;
  wire [31:0] MEMWB_retAddrOut;
  MEMWBReg MEMWBRegister(clkIn,rstn,EXMEM_rdOut,EXMEM_retAddrOut,EXMEM_Imm32Out,DMem_DataOut,EXMEM_ResultOut,EXMEM_ctrSignalsOut
  ,MEMWB_rdOut,MEMWB_retAddrOut,MEMWB_Imm32Out,MEMWB_Data2Out,MEMWB_ResultOut,MEMWB_ctrSignalsOut);
  
  //module DataMUX(ResultIn,Imm32In,DataIn,SeqAddrIn,SelectorIn,DataOut); 
  DataMUX myDataMUX(MEMWB_ResultOut,MEMWB_Imm32Out,MEMWB_Data2Out,MEMWB_retAddrOut,MEMWB_ctrSignalsOut[10:9],DataMUX_DataOut);
  
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





