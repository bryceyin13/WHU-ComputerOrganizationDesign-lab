module PC(clkIn,resetIn,AddrIn,AddrOut);
  input clkIn;
  input resetIn;
  input[31:0] AddrIn;
  output reg[31:0] AddrOut;

  always @(posedge clkIn) begin
    if (resetIn) AddrOut<=0;
    else AddrOut<=AddrIn;
  end
endmodule
