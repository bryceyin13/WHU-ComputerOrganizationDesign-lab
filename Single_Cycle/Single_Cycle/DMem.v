module DMem(clkIn,resetIn,AddrIn,DataIn,ReadIn,WriteIn,DataOut);
  input clkIn;          //from outside
  input resetIn;
  input[31:0] AddrIn;   //from ALU
  input[31:0] DataIn;   //from Reg
  input ReadIn;         //from Controller
  input WriteIn;        //from Controller
  output[31:0] DataOut; //to DataMUX

  reg[31:0] RAM[31:0];  //store data
  integer k;
  assign DataOut=ReadIn?RAM[AddrIn]:0;
  always @(posedge clkIn) begin
    if (resetIn) begin
      for (k=0;k<32;k=k+1) RAM[k]<=0;
    end
    else if (WriteIn) RAM[AddrIn]<=DataIn;
  end
endmodule


