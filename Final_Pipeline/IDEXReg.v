`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/13 10:09:45
// Design Name: 
// Module Name: IDEXReg
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


module IDEXReg(clkIn,resetn,flushIn,stallIn,rs1In,rs2In,rdIn,AddrIn,ImmIn,
Data1In,Data2In,rdOut,rs1Out,rs2Out,AddrOut,ImmOut,Data1Out,Data2Out,ctrSignalsIn,ctrSignalsOut);
input clkIn;
input resetn;
input flushIn;       
input stallIn;
input[4:0] rs1In;
input[4:0] rs2In;        
input[4:0] rdIn;
input[31:0] AddrIn;
input[31:0] ImmIn;
input[31:0] Data1In;
input[31:0] Data2In;
input[11:0] ctrSignalsIn;
output reg [4:0] rdOut;
output reg [4:0] rs1Out;
output reg [4:0] rs2Out;
output reg [31:0] AddrOut;
output reg [31:0] ImmOut;
output reg [31:0] Data1Out;
output reg [31:0] Data2Out;
output reg [11:0] ctrSignalsOut;

always @(posedge clkIn) begin
   if(~resetn)begin
      rdOut<=5'b0;
      AddrOut<=32'b0;
      ImmOut<=32'b0;
      Data1Out<=32'b0;
      Data2Out<=32'b0;
      ctrSignalsOut<=12'b0;
      rs1Out<=5'b0;
      rs2Out<=5'b0;
   end
   else if(flushIn)begin
      rdOut<=5'b0;
      AddrOut<=32'b0;
      ImmOut<=32'b0;
      Data1Out<=32'b0;
      Data2Out<=32'b0;
      ctrSignalsOut<=12'b0;
      rs1Out<=5'b0;
      rs2Out<=5'b0;
   end
   else if(stallIn==0)begin
      rdOut<=rdIn;
      AddrOut<=AddrIn;
      ImmOut<=ImmIn;
      Data1Out<=Data1In;
      Data2Out<=Data2In;
      ctrSignalsOut=ctrSignalsIn;
      rs1Out<=rs1In;
      rs2Out<=rs2In;
   end
   else begin
      rdOut<=5'b0;
      AddrOut<=32'b0;
      ImmOut<=32'b0;
      Data1Out<=32'b0;
      Data2Out<=32'b0;
      ctrSignalsOut<=12'b0;
      rs1Out<=5'b0;
      rs2Out<=5'b0;
   end
end

endmodule
