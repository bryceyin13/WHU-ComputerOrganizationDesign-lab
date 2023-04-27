module PCRelAddrAdder(OffsetIn,AddrIn,AddrOut);
  input[31:0] OffsetIn; //from ImmGen
  input[31:0] AddrIn;   //from PC
  output[31:0] AddrOut; //to AddrMUX
  assign AddrOut=AddrIn+OffsetIn;
endmodule

