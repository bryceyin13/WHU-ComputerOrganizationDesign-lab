module ImmGen(InsIn,Imm32Out);
  input[31:0] InsIn;         //from IMem
  output reg[31:0] Imm32Out; //to PCPlusOffsetAdder,ALUMUX,DataMUX

  wire[4:0] opcode;
  assign opcode=InsIn[4:0];
  wire[4:0] imm5;
  assign imm5=InsIn[11:7];
  wire[5:0] imm6;
  assign imm6=InsIn[25:20];
  wire[6:0] imm7;
  assign imm7=InsIn[31:25];
  wire[11:0] imm12;
  assign imm12=InsIn[31:20];
  wire[19:0] imm20;
  assign imm20=InsIn[31:12];
  always @(InsIn) begin
    case (opcode)
      5'b00010: if (imm12[11]) Imm32Out<={20'hfffff,imm12[11:0]};
                else Imm32Out<={20'h00000,imm12[11:0]};
      5'b00101: Imm32Out<={20'h00000,imm12[11:0]};
      5'b00111: Imm32Out<={20'h00000,imm12[11:0]};
      5'b01001: Imm32Out<={20'h00000,imm12[11:0]};
      5'b01011: Imm32Out<={26'h0000000,imm6[5:0]};
      5'b01101: Imm32Out<={26'h0000000,imm6[5:0]};
      5'b01110: Imm32Out<={imm20,12'h000};
      5'b01111: if (imm12[11]) Imm32Out<={20'hfffff,imm12[11:0]};
                else Imm32Out<={20'h00000,imm12[11:0]};
      5'b10000: if (imm7[6]) Imm32Out<={20'hfffff,imm7[6:0],imm5[4:0]};
                else Imm32Out<={20'h00000,imm7[6:0],imm5[4:0]};
      5'b10001: if (imm7[6]) Imm32Out<={20'hfffff,imm7[6:0],imm5[4:0]};
                else Imm32Out<={20'h00000,imm7[6:0],imm5[4:0]};
      5'b10010: if (imm7[6]) Imm32Out<={20'hfffff,imm7[6:0],imm5[4:0]};
                else Imm32Out<={20'h00000,imm7[6:0],imm5[4:0]};
      5'b10011: if (imm20[19]) Imm32Out<={12'hfff,imm20[19:0]};
                else Imm32Out<={12'h000,imm20[19:0]};
      5'b10100: if (imm12[11]) Imm32Out<={20'hfffff,imm12[11:0]};
                else Imm32Out<={20'h00000,imm12[11:0]};
       default: Imm32Out<=32'h00000000;
    endcase
  end
endmodule

