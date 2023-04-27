module AddrMUX(LessIn,ZeroIn,RegRelAddrIn,
               PCRelAddrIn,SeqAddrIn,SelectorIn,AddrOut);
  input LessIn;              //from ALU
  input ZeroIn;              //from ALU
  input[31:0] RegRelAddrIn;  //from ALU
  input[31:0] PCRelAddrIn;   //from PCPlusOffsetAdder
  input[31:0] SeqAddrIn;     //from PCPlus1Adder
  input[2:0] SelectorIn;     //from Controller
  output reg[31:0] AddrOut;  //to PC

  always @(*) begin
    if (SelectorIn==0) AddrOut<=SeqAddrIn;
    else if (SelectorIn==1) begin             //blt     
      if (LessIn==1) AddrOut<=PCRelAddrIn; 
      else AddrOut<=SeqAddrIn;
    end
    else if (SelectorIn==2) begin             //beq
      if (ZeroIn==1) AddrOut<=PCRelAddrIn; 
      else AddrOut<=SeqAddrIn;
    end
    else if (SelectorIn==3) AddrOut<=PCRelAddrIn;    //jal
    else if (SelectorIn==4) AddrOut<=RegRelAddrIn;    //jalr
    else AddrOut<=0;  //reset
  end
endmodule


