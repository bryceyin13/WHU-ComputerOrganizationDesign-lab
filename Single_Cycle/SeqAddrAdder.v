module SeqAddrAdder(AddrIn,AddrOut);
  input[31:0] AddrIn;   //from PC
  output[31:0] AddrOut; //to AddrMUX,DataMUX
  assign AddrOut=AddrIn+1;
endmodule

