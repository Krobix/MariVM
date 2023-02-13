import std.string;
import instruction;
import mariobject;

//VM implementation

struct Context {
    MariObject[10] registers;
    MariObject[string] varTable;
    Context parentContext;
}

class VM {

    private int ip; //instruction pointer
    private Instruction[] code;
    private Context rootContext;
    private Context currentContext;
    
}