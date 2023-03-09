import std.stdio;
import pegged.grammar;
import mariobject;
import instruction;

mixin(grammar("

MariGrammar:

    strlit <- (quote / doublequote) (. / '')+ (quote / doublequote)

    instruction < op (expr ',')* expr? ';'

    expr <- strlit / regname / varname / decimal / number / codeblock

    codeblock < '{' (instruction)+ '}'
    
    op <- 'intadd' / 'intsub' / 'intmul' / 'intdiv' / 'intmod' / 'fladd' / 'flsub' / 'flmul' / 'fldiv' / 
    'stradd' / 'intnew' / 'flnew' / 'strnew' / 'log' / 'store' / 'load' / 'defvar' / 'delete' / 'free' / 'pop'
    
    regname <- '$reg' [0-9]
    
    varname <- identifier
    
    decimal <- '-'? [0-9]+ '.' [0-9]+
    
    number <- '-'? [0-9]+ 

"));

Instruction[] compileFromString(string code){
    Instruction[] instructions;
    auto tree = MariGrammar(code);
    
    version(GrammarTest){
        writeln(tree);
    }

    return instructions;
}