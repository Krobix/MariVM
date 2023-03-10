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
    "defvar":Opcode.DEFVAR, "delete":Opcode.DELETE, "free":Opcode.FREE, "pop":Opcode.POP];
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
    'stradd' / 'intnew' / 'flnew' / 'strnew' / 'log' / 'store' / 'load' / 'defvar' / 'delete' / 'free' / 'pop'
    
    regname <- '$reg' [0-9]
    
    varname <- identifier
    
    decimal <- '-'? [0-9]+ '.' [0-9]+
    
    number <- '-'? [0-9]+ 

"));

InstructionParam exprToInstructionParam(ParseTree tree){
    ParseTree expr = tree.children[0];
    InstructionParam param;
    InstructionParamValue paramValue;
    MariPrimitiveValue primitiveValue;

    switch(expr.name){
        case "MariGrammar.strlit":
            param.type = InstructionParamType.STRLIT;
            primitiveValue.stringValue = to!string(expr.matches);
            paramValue.literalValue = primitiveValue;
            break;
        case "MariGrammar.decimal":
            param.type = InstructionParamType.FLLIT;
            primitiveValue.floatValue = to!float(to!string(expr.matches));
            paramValue.literalValue = primitiveValue;
            break;
        case "MariGrammar.number":
            param.type = InstructionParamType.INTLIT;
            primitiveValue.intValue = to!int(to!string(expr.matches));
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
        InstructionParam[iTree.children.length-1] iParams;
        i.op = OPMAP[iTree.matches[0]];
        for(int j=1; j<iTree.children.length; j++){
            iParams[j] = exprToInstructionParam(iTree.children[j]);
        }
        i.params = iParams;
        instructions ~= i;
    }

    return instructions;
}