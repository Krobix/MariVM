import std.string;
import instruction;
import mariobject;

//VM implementation

class Context {
    private MariObject[10] registers;
    private MariObject[] stack;
    private int[string] varTable;
    private Context parentContext;

    this(){
        this.stack = new MariObject[10];
        this.parentContext = null;
    }

    this(Context ctx){
        //Note: this constructor is used to create a child Context
        this.stack = new MariObject[10];
        this.parentContext = ctx;
    }
}

class VM {

    private int ip; //instruction pointer
    private Instruction[] code;
    private Context rootContext;
    private Context currentContext;

}