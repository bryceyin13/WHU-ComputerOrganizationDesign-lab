module IMem(AddrIn,InsOut);
  input[31:0] AddrIn;           //from PC
  output[31:0] InsOut;          //to Controller,Reg,ImmGen
  wire[31:0] ROM[81:0];
         // store test program
  /**/
   // the last instruction
         /*
  assign ROM[0]=32'h0000008e; // the first instruction
  assign ROM[1]=32'h0000010e;
  assign ROM[2]=32'h0;
  assign ROM[3]=32'h0;
  assign ROM[4]=32'h0;
  assign ROM[5]=32'h00a10102;
  assign ROM[6]=32'h0000018e;
  assign ROM[7]=32'h0;
  assign ROM[8]=32'h0;
  assign ROM[9]=32'h0;
  assign ROM[10]=32'h00a18182;
  assign ROM[11]=32'h00208010;
  assign ROM[12]=32'h00108082;
  assign ROM[13]=32'hfff10102;
  assign ROM[14]=32'h0;
  assign ROM[15]=32'h0;
  assign ROM[16]=32'hfe308d91;
  assign ROM[17]=32'h0;
  assign ROM[18]=32'h0;
  assign ROM[19]=32'h0;
  assign ROM[20]=32'h0000008e;
  assign ROM[21]=32'h0;
  assign ROM[22]=32'h0;
  assign ROM[23]=32'h0;
  assign ROM[24]=32'h00908082;
  assign ROM[25]=32'h00000f0e;
  assign ROM[26]=32'h0;
  assign ROM[27]=32'h0;
  assign ROM[28]=32'h0;
  assign ROM[29]=32'h03e08112;
  assign ROM[30]=32'h0;
  assign ROM[31]=32'h0;
  assign ROM[32]=32'h0;
  assign ROM[33]=32'h00008102;
  assign ROM[34]=32'h0000018e;
  assign ROM[35]=32'h0;
  assign ROM[36]=32'h0;
  assign ROM[37]=32'h01e10a92;
  assign ROM[38]=32'h0;
  assign ROM[39]=32'h0;
  assign ROM[40]=32'h0;
  assign ROM[41]=32'h0001820f;
  assign ROM[42]=32'h0011828f;
  assign ROM[43]=32'h0;
  assign ROM[44]=32'h0;
  assign ROM[45]=32'h0;
  assign ROM[46]=32'h00520311;
  assign ROM[47]=32'h0;
  assign ROM[48]=32'h0;
  assign ROM[49]=32'h0;
  assign ROM[50]=32'h00418090;
  assign ROM[51]=32'h00518010;
  assign ROM[52]=32'h00118182;
  assign ROM[53]=32'hfff10102;
  assign ROM[54]=32'hfe000792;
  assign ROM[55]=32'h0;
  assign ROM[56]=32'h0;
  assign ROM[57]=32'h0;
  assign ROM[58]=32'hfff08082;
  assign ROM[59]=32'hfe000112;
  assign ROM[60]=32'h0;
  assign ROM[61]=32'h0;
  assign ROM[62]=32'h0;
  assign ROM[63]=32'h0000008e;
  assign ROM[64]=32'h0000010e;
  assign ROM[65]=32'h0;
  assign ROM[66]=32'h0;
  assign ROM[67]=32'h0;
  assign ROM[68]=32'h00a10102;
  assign ROM[69]=32'h00008f8f;
  assign ROM[70]=32'h00108082;
  assign ROM[71]=32'h0;
  assign ROM[72]=32'h0;
  assign ROM[73]=32'h0;
  assign ROM[74]=32'hfe208d91;
  assign ROM[75]=32'h0;
  assign ROM[76]=32'h0;
  assign ROM[77]=32'h0;
  assign ROM[78]=32'h00000012;
  assign ROM[79]=32'h0;
  assign ROM[80]=32'h0;
  assign ROM[81]=32'h0;*/
  
  assign ROM[0]=32'h00000f0e; // the first instruction
  assign ROM[1]=32'h0000008e;
  assign ROM[2]=32'h00808082;
  assign ROM[3]=32'h00003113;
  assign ROM[4]=32'h00018f82;
  assign ROM[5]=32'h00000012;
  assign ROM[6]=32'h0000018e;
  assign ROM[7]=32'h00118182;
  assign ROM[8]=32'h0000020e;
  assign ROM[9]=32'h00320202;
  assign ROM[10]=32'h00408911;
  assign ROM[12]=32'h002f0010;
  assign ROM[13]=32'h001f0f02;
  assign ROM[11]=32'hfff08082;
  assign ROM[14]=32'h001f0010;
  assign ROM[15]=32'h001f0f02;
  assign ROM[16]=32'hffff6113;
  assign ROM[17]=32'hffff0f02;
  assign ROM[18]=32'h000f008f;
  assign ROM[20]=32'h003f0010;
  assign ROM[21]=32'h001f0f02;
  assign ROM[19]=32'hfff08082;
  assign ROM[22]=32'hffff0113;
  assign ROM[23]=32'hffff0f02;
  assign ROM[24]=32'h000f028f;
  assign ROM[25]=32'h00518181;
  assign ROM[26]=32'hffff0f02;
  assign ROM[27]=32'h000f010f;
  assign ROM[28]=32'h00010014;
  assign ROM[29]=32'b0;
  assign ROM[30]=32'b0;
  assign ROM[31]=32'b0;
   // the last instruction
  assign InsOut=ROM[AddrIn];
endmodule

