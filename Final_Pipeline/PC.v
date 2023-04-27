module PC(clkIn,resetIn,AddrIn,flushIn,stallIn,AddrOut);
  input clkIn;
  input resetIn;
  input[31:0] AddrIn;
  input flushIn;
  input stallIn;
  output reg[31:0] AddrOut;

  always @(posedge clkIn) begin
    if (~resetIn) AddrOut<=0;
    else if (flushIn) AddrOut<=AddrIn;
    else if (stallIn==0) AddrOut<=AddrIn;
  end
endmodule
