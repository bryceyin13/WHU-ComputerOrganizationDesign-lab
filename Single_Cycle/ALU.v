module ALU(Data1In,Data2In,OperatorIn,LessOut,ZeroOut,ResultOut);
  input[31:0] Data1In;        //from Reg
  input[31:0] Data2In;        //from ALUMUX
  input[2:0] OperatorIn;      //from Controller
  output LessOut;             //to AddrMUX
  output ZeroOut;             //to AddrMUX
  output reg[31:0] ResultOut; //to DataMUX,DMem,AddrMUX

  always @(*) begin
    case (OperatorIn)
      3'b001: ResultOut<=Data1In+Data2In; //add,addi
      3'b010: ResultOut<=Data1In-Data2In; //sub
      3'b011: ResultOut<=Data1In&Data2In; //and, andi
      3'b100: ResultOut<=Data1In|Data2In; //or, or
      3'b101: ResultOut<=Data1In^Data2In; //xor£¬xori
      3'b110: if (Data2In>31) ResultOut<=32'h00000000;
              else if (Data2In>0) ResultOut<=Data1In<<Data2In; //sll,slli
              else ResultOut<=Data1In;
      3'b111: if (Data2In>31) ResultOut<=32'h00000000;
              else if (Data2In>0) ResultOut<=Data1In>>Data2In; //srl,srli
              else ResultOut<=Data1In;
     default: ResultOut<=32'h00000000; //other cases
    endcase
  end  
  assign LessOut=(Data1In<Data2In)?1:0;
  assign ZeroOut=(ResultOut==0)?1:0;
endmodule

