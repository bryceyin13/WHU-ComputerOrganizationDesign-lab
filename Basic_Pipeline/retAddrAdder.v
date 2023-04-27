`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/14 21:48:33
// Design Name: 
// Module Name: retAddrAdder
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


module retAddrAdder(AddrIn,AddrOut);
  input[31:0] AddrIn;
  output[31:0] AddrOut;
  assign AddrOut=AddrIn+1;
endmodule
