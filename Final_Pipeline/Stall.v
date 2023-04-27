module Stall(
  input[4:0] IFIDrs1In,    //from IFID
  input[4:0] IFIDrs2In,    //from IFID
  input      IDEXIn,   //from IDEX
  input[4:0] IDEXrdIn,     //from IDEX
  input      MEMWBRegWriteIn,
  input[4:0] MEMWBrdIn,  
  output reg stallOut  //to   PC,IFID,IDEX
);

  always @(*) begin
    if ((IDEXIn)&&(IDEXrdIn==IFIDrs1In||IDEXrdIn==IFIDrs2In)) stallOut<=1;
    else if ((MEMWBRegWriteIn)&&(MEMWBrdIn==IFIDrs1In||MEMWBrdIn==IFIDrs2In)) stallOut<=1;
    else stallOut<=0;
  end
endmodule
