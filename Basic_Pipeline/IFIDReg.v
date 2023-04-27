`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/13 10:09:45
// Design Name: 
// Module Name: IFIDReg
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


module IFIDReg(clkIn,resetn,AddrIn,AddrOut,InsIn,InsOut);
input clkIn;
input resetn;
input [31:0]AddrIn;
input [31:0]InsIn;
output reg [31:0] AddrOut;
output reg [31:0] InsOut;

always @(posedge clkIn) begin
   if(~resetn)begin
      InsOut<=32'b0;
      AddrOut<=32'b0;
   end
   else begin
       AddrOut<=AddrIn;
       InsOut<=InsIn;
   end
end

endmodule
