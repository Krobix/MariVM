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
    //load put value into a specified register
    LOAD,
    //save value from register to top of stack and define a new variable with given name that points to this address
    DEFVAR,
    //delete a variable
    DELETE,
    //delete a variable and delete the object taht it points to
    FREE,
    //remove object from top of stack if it exists and move to reg0
    POP,
    //convert integer to string
    INTTOSTR,
    //convert float to string
    FLTOSTR,
    //convert string to integer
    STRTOINT,
    //convert float to integer
    STRTOFL
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
    VARNAME,
    //code block
    CODEBLOCK
}

union InstructionParamValue {
    int registerAddress; //0-9 int
    string varName;
    MariPrimitiveValue literalValue;
    Instruction[] codeblock;
}

struct InstructionParam {
    InstructionParamType type;
    InstructionParamValue value;
}

struct Instruction {
    Opcode op;
    InstructionParam[] params;
}