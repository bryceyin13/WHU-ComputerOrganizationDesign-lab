module FWDMUX(
  input[31:0]      IDEXdata1In,
  input[31:0]      IDEXdata2In,
  input[31:0]      EXMAresultIn,  //from EXMA
  input[31:0]      EXMAimm32In,
  input[31:0]      EXMAaddrIn,
  input[31:0]      MAWBdataIn,
  input[2:0]       forward1In,
  input[2:0]       forward2In,
  output reg[31:0] data1Out,
  output reg[31:0] data2Out
);

  always @(IDEXdata1In,EXMAresultIn,EXMAimm32In,EXMAaddrIn,MAWBdataIn,forward1In) begin
    if      (forward1In==0) data1Out<=IDEXdata1In;
    else if (forward1In==1) data1Out<=EXMAresultIn;
    else if (forward1In==2) data1Out<=EXMAimm32In;
    else if (forward1In==3) data1Out<=EXMAaddrIn;
    else if (forward1In==4) data1Out<=MAWBdataIn;
    else                    data1Out<=0;
  end                         
  always @(IDEXdata2In,EXMAresultIn,EXMAimm32In,EXMAaddrIn,MAWBdataIn,forward2In) begin
    if      (forward2In==0) data2Out<=IDEXdata2In;
    else if (forward2In==1) data2Out<=EXMAresultIn;
    else if (forward2In==2) data2Out<=EXMAimm32In;
    else if (forward2In==3) data2Out<=EXMAaddrIn;
    else if (forward2In==4) data2Out<=MAWBdataIn;
    else                    data2Out<=0;
  end
endmodule
