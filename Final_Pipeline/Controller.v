module Controller(opcodeIn,ctrSignalsOut);
  input[4:0] opcodeIn; //from IMem
  output reg[11:0] ctrSignalsOut; 
  //to Reg,DataMUX,DMem,AddrMUX,ALU,ALUMUX
  //ctrSignals[11]: RegWrite,to Reg
  //ctrSignals[10:9]: DataSelector,to DataMUX
  //ctrSignals[8]: MemRead,to DMem
  //ctrSignals[7]: MemWrite,to DMem
  //ctrSignals[6:4]: AddrSelector,to AddrMUX
  //ctrSignals[3:1]: ALUOperator,to ALU
  //ctrSignals[0]: ALUSelector,to ALUMUX
  
  always @(*) begin
    case (opcodeIn)
      5'b00001: ctrSignalsOut<=12'b100000000011; //add++ 
      5'b00010: ctrSignalsOut<=12'b100000000010; //addi++
      5'b00011: ctrSignalsOut<=12'b100000000101; //sub  
      5'b00100: ctrSignalsOut<=12'b100000000111; //and
      5'b00101: ctrSignalsOut<=12'b100000000110; //andi
      5'b00110: ctrSignalsOut<=12'b100000001001; //or
      5'b00111: ctrSignalsOut<=12'b100000001000; //ori
      5'b01000: ctrSignalsOut<=12'b100000001011; //xor
      5'b01001: ctrSignalsOut<=12'b100000001010; //xori
      5'b01010: ctrSignalsOut<=12'b100000001101; //sll
      5'b01011: ctrSignalsOut<=12'b100000001100; //slli
      5'b01100: ctrSignalsOut<=12'b100000001111; //srl
      5'b01101: ctrSignalsOut<=12'b100000001110; //srli
      5'b01110: ctrSignalsOut<=12'b101000000000; //lui++
      5'b01111: ctrSignalsOut<=12'b110100000010; //lw++
      5'b10000: ctrSignalsOut<=12'b000010000010; //sw++
      5'b10001: ctrSignalsOut<=12'b000000010101; //blt++
      5'b10010: ctrSignalsOut<=12'b000000100101; //beq++
      5'b10011: ctrSignalsOut<=12'b111000110000; //jal
      5'b10100: ctrSignalsOut<=12'b111001000010; //jalr
       default: ctrSignalsOut<=12'b000000000000; //other cases
    endcase
  end
endmodule

