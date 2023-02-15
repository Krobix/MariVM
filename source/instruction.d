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
    //save value from register to top of stack
    STORE,
    //load value from a variable to a register
    LOAD,
    //save value from register to top of stack and define a new variable with given name taht points to this address
    DEFVAR,
    //delete a variable
    DELETE,
    //delete a variable and delete the object taht it points to
    FREE
}

enum InstructionParamType {
    //integer literal
    INTLIT = 0,
    //float literal
    FLLIT,
    //string literal
    STRLIT,
    //Value from register
    REGISTER,
    //Name of variable
    VARNAME
}

union InstructionParamValue {
    int registerAddress; //0-9 int
    string varName;
    MariPrimitiveValue literalValue;
}

struct InstructionParam {
    InstructionParamType type;
    InstructionParamValue value;
}

struct Instruction {
    Opcode op;
    InstructionParam[] params;
}