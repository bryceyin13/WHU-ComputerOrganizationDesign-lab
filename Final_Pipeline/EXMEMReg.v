`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/13 10:09:45
// Design Name: 
// Module Name: EXMEMReg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module EXMEMReg(clkIn,resetn,flushIn,rdIn,AddrIn,retAddrIn,ImmIn,Data2In,LessIn,ZeroIn,ResultIn,Ctrl_signalIn,rdOut,AddrOut,retAddrOut,ImmOut,Data2Out,LessOut,ZeroOut,ResultOut,ctrSignalsOut);

input clkIn;
input resetn;
input flushIn;
input[4:0] rdIn;
input[31:0] AddrIn;
input[31:0] retAddrIn;
input[31:0] ImmIn;
input[31:0] Data2In;
input LessIn;
input ZeroIn;
input[31:0] ResultIn;
input[11:0] Ctrl_signalIn;
output reg [4:0] rdOut;
output reg [31:0] AddrOut;
output reg [31:0] retAddrOut;
output reg [31:0] ImmOut;
output reg [31:0] Data2Out;
output reg LessOut;
output reg ZeroOut;
output reg [31:0] ResultOut;
output reg [11:0] ctrSignalsOut;

always @(posedge clkIn) begin
   if(~resetn)begin
      rdOut<=5'b0;
      AddrOut<=32'b0;
      retAddrOut<=32'b0;
      ImmOut<=32'b0;
      Data2Out<=32'b0;
      LessOut<=0;
      ZeroOut<=0;
      ResultOut<=32'b0;
      ctrSignalsOut<=12'b0;
   end
   else if(flushIn)begin
      rdOut<=5'b0;
      AddrOut<=32'b0;
      retAddrOut<=32'b0;
      ImmOut<=32'b0;
      Data2Out<=32'b0;
      LessOut<=0;
      ZeroOut<=0;
      ResultOut<=32'b0;
      ctrSignalsOut<=12'b0;
   end 
   else begin
      rdOut<=rdIn;
      AddrOut<=AddrIn;
      retAddrOut<=retAddrIn;
      ImmOut<=ImmIn;
      Data2Out<=Data2In;
      LessOut<=LessIn;
      ZeroOut<=ZeroIn;
      ResultOut<=ResultIn;
      ctrSignalsOut<=Ctrl_signalIn;
   end
end

endmodule
