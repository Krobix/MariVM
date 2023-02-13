import mariobject;
//Opcodes and Instructions

enum Opcode {
    //integer add
    INTADD = 0,
    //integer subtrtact
    INTSUB,
    //integer multiply
    INTMUL,
    //integer divide
    INTDIV,
    //integer modulus
    INTMOD,
    //float add
    FLADD,
    //float subtract
    FLSUB,
    //float multiply
    FLMUL,
    //float divide
    FLDIV,
    //string add (concatenation)
    STRADD,
    //integer new (create new integer)
    INTNEW,
    //float new
    FLNEW,
    //string new
    STRNEW,
    //output to terminal
    LOG,
    //save value from register as a variable
    SAVE,
    //load value from a variable to a register
    LOAD,
    //delete a variable
    DELETE
}

enum InstructionParamType {
    //integer literal
    INTLIT = 0,
    //float literal
    FLLIT,
    //string literal
    STRLIT,
    //Value from register
    REGISTER
}

union InstructionParam {
    int registerAddress; //0-9 int
    MariPrimitiveValue literalValue;
}

struct Instruction {
    Opcode op;
    InstructionParam[] params;
}