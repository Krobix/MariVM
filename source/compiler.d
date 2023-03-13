import std.stdio;
import std.conv;
import pegged.grammar;
import mariobject;
import instruction;

immutable Opcode[string] OPMAP;

pure shared static this(){
    OPMAP = ["intadd":Opcode.INTADD, "intsub":Opcode.INTSUB, "intmul":Opcode.INTMUL, "intdiv":Opcode.INTDIV,
    "intmod":Opcode.INTMOD, "fladd":Opcode.FLADD, "flsub":Opcode.FLSUB, "flmul":Opcode.FLMUL, "fldiv":Opcode.FLDIV, "stradd":Opcode.STRADD,
    "intnew":Opcode.INTNEW, "flnew":Opcode.FLNEW, "strnew":Opcode.STRNEW, "log":Opcode.LOG, "store":Opcode.STORE, "load":Opcode.LOAD, 
    "defvar":Opcode.DEFVAR, "delete":Opcode.DELETE, "free":Opcode.FREE, "pop":Opcode.POP, "inttostr":Opcode.INTTOSTR, "fltostr":Opcode.FLTOSTR,
    "strtoint":Opcode.STRTOINT, "strtofl":Opcode.STRTOFL];
}

mixin(grammar("

MariGrammar:

    code < instruction+

    instruction < op (expr :',')* expr? :';'
    
    strlit <- doublequotestr / singlequotestr

    doublequotestr <- :(doublequote) (!(doublequote) (. / ''))+ :(doublequote)

    singlequotestr <- :(quote) (!(quote) (. / ''))+ :(quote)

    expr <- strlit / regname / varname / decimal / number / codeblock

    codeblock < '{' (instruction)+ '}'
    
    op <- 'intadd' / 'intsub' / 'intmul' / 'intdiv' / 'intmod' / 'fladd' / 'flsub' / 'flmul' / 'fldiv' / 
    'stradd' / 'intnew' / 'flnew' / 'strnew' / 'log' / 'store' / 'load' / 'defvar' / 'delete' / 'free' / 'pop' /
    'inttostr' / 'fltostr' / 'strtoint' / 'strtofl'
    
    regname <- '$reg' [0-9]
    
    varname <- identifier
    
    decimal <- '-'? [0-9]+ '.' [0-9]+
    
    number <- '-'? [0-9]+ 

"));

string joinStrArray(string[] arr){
    string output = "";
    foreach(string s; arr){
        output ~= s;
    }
    return output;
}

InstructionParam exprToInstructionParam(ParseTree tree){
    ParseTree expr = tree.children[0];
    InstructionParam param;
    InstructionParamValue paramValue;
    MariPrimitiveValue primitiveValue;

    switch(expr.name){
        case "MariGrammar.strlit":
            param.type = InstructionParamType.STRLIT;
            primitiveValue.stringValue = to!string(joinStrArray(expr.matches));
            paramValue.literalValue = primitiveValue;
            break;
        case "MariGrammar.decimal":
            param.type = InstructionParamType.FLLIT;
            primitiveValue.floatValue = to!float(to!string(joinStrArray(expr.matches)));
            paramValue.literalValue = primitiveValue;
            break;
        case "MariGrammar.number":
            param.type = InstructionParamType.INTLIT;
            primitiveValue.intValue = to!int(to!string(joinStrArray(expr.matches)));
            paramValue.literalValue = primitiveValue;
            break;
        case "MariGrammar.regname":
            param.type = InstructionParamType.REGISTER;
            paramValue.registerAddress = to!int(expr.matches[1]);
            break;
        case "MariGrammar.varname":
            param.type = InstructionParamType.VARNAME;
            paramValue.varName = to!string(expr.matches);
            break;
        case "MariGrammar.codeblock":
            //TODO
            break;
        default: break;
    }

    param.value = paramValue;
    return param;
}

Instruction[] compileFromString(string code){
    Instruction[] instructions;
    auto tree = MariGrammar(code);
    
    //writeln(tree.children[0].children); //for testing purposes -- comment this out

    foreach(ParseTree iTree; tree.children[0].children){
        Instruction i;
        InstructionParam[] iParams;
        i.op = OPMAP[iTree.matches[0]];

        debug {
            writeln("[DEBUG] Compiling line: " ~ to!string(iTree.matches));
        }

        for(int j=1; j<iTree.children.length; j++){
            iParams ~= exprToInstructionParam(iTree.children[j]);
        }
        i.params = iParams;
        instructions ~= i;
    }

    return instructions;
}