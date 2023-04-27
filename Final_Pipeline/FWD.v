module FWD(
  input[4:0]      IDEXrs1In,    //from IDEX
  input[4:0]      IDEXrs2In,    //from IDEX
  input           EXMAwriteIn,  //from EXMA
  input[4:0]      EXMArdIn,     //from EXMA
  input[1:0]      EXMADataSelectorIn,     //from EXMA,ctrSignals for DataMUX
  input           MAWBwriteIn,  //from MAWB
  input[4:0]      MAWBrdIn,     //from MAWB
  output reg[2:0] forward1Out,     //to   FWDMUX
  output reg[2:0] forward2Out      //to   FWDMUX
);

  always @(*) begin
    if ((EXMAwriteIn)&&(EXMArdIn==IDEXrs1In)) begin
      if      (EXMADataSelectorIn==0) forward1Out<=1;
      else if (EXMADataSelectorIn==1) forward1Out<=2;
      else if (EXMADataSelectorIn==3) forward1Out<=3;
      else                            forward1Out<=5;
    end
    else if ((MAWBwriteIn)&&(MAWBrdIn==IDEXrs1In)) forward1Out<=4;
    else forward1Out<=0;
  end

  always @(*) begin
    if ((EXMAwriteIn)&&(EXMArdIn==IDEXrs2In)) begin
      if      (EXMADataSelectorIn==0) forward2Out<=1;
      else if (EXMADataSelectorIn==1) forward2Out<=2;
      else if (EXMADataSelectorIn==3) forward2Out<=3;
      else                            forward2Out<=5; //in this case,the pipeline will be stalled
    end
    else if ((MAWBwriteIn)&&(MAWBrdIn==IDEXrs2In)) forward2Out<=4;
    else forward2Out<=0;
  end

endmodule
