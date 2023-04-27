module Flush(
  input lessIn,         //from EXMA
  input zeroIn,         //from EXMA
  input[2:0] AddrSelectorIn,  //from EXMA 
  output reg flushOut   //to IFID,IDEX,EXMA
);

  always @(*) begin
    if (AddrSelectorIn==1) begin  //blt
      if (lessIn==1) flushOut<=1; 
      else flushOut<=0; 
    end
    else if (AddrSelectorIn==2) begin  //beq
      if (zeroIn==1) flushOut<=1;
      else flushOut<=0;
    end
    else if (AddrSelectorIn==3) flushOut<=1;  //jal
    else if (AddrSelectorIn==4) flushOut<=1;  //jalr
    else flushOut<=0;
  end
endmodule
