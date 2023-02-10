

//Opcodes and Instructions

enum Opcode {
    //integer add
    IADD = 0,
    //integer subtrtact
    ISUB,
    //integer multiply
    IMUL,
    //integer divide
    IDIV,
    //integer modulus
    IMOD,
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
    INEW,
    //float new
    FLNEW,
    //string new
    STRNEW,
    //output to terminal
    PRINT
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

struct Instruction {
    Opcode op;

}