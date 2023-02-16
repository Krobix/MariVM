import std.string;
import std.algorithm.mutation;
import std.conv;
import std.array;
import instruction;
import mariobject;

//VM implementation

class Context {
    private int ip; //instruction pointer
    private string ctxIdentifier;
    private MariObject[10] registers;
    private MariObject[] stack;
    private int[string] varTable;
    private Context parentContext;

    this(string id){
        this.ctxIdentifier = id;
        this.stack = new MariObject[1];
        this.parentContext = null;
        this.ip = 0;
    }

    this(string id, Context ctx){
        //this constructor is used to create a child Context
        this.ctxIdentifier = id;
        this.stack = new MariObject[1];
        this.parentContext = ctx;
        this.ip = 0;
    }

    public void setReg(int index, MariObject value){
        this.registers[index] = value;
    }

    public MariObject getReg(int index){
        return this.registers[index];
    }

    public MariObject getVarValue(string name){
        return this.stack[this.varTable[name]];
    }

    public int getVarAddress(string name){
        return this.varTable[name];
    }

    public void setVar(string name, int address){
        this.varTable[name] = address;
    }

    public void pushToStack(MariObject obj){
        this.stack ~= obj;
    }

    public MariObject getFromStack(int index){
        return this.stack[index];
    }

    public MariObject getFromTopOfStack(){
        return this.stack[$-1];
    }

    public void deleteFromStack(int index){
        this.stack = remove(this.stack, index);
    }

    public void deleteFromTopOfStack(){
        this.deleteFromStack(to!int(this.stack.length-1));
    }

    public Context getParent(){
        return this.parentContext;
    }

    public string getIdentifier(){
        return this.ctxIdentifier;
    }

    public int getIP(){
        return this.ip;
    }

    public int incrementIP(){
        return ++this.ip;
    }

    public int setIP(int i){
        this.ip = i;
        return this.ip;
    }
}

class VM {

    private bool errorStatus;
    private Instruction[] code;
    private Context rootContext;
    private Context currentContext;

    //start of vm operation methods

    private void instIntAdd(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        if(!(x.isPrimitiveType(MariPrimitiveType.INT) && y.isPrimitiveType(MariPrimitiveType))) {
            this.throwRuntimeException("TypeError", "INTADD instruction requires two integers");
        }
        else {
            
        }
    }

    //-----------------------------

    this(Instruction[] code){
        this.code = code;
        this.rootContext = new Context("rootContext");
        this.currentContext = this.rootContext;
        this.ip = 0;
        this.errorStatus = false;
    }

    public MariObject instructionParamToObject(InstructionParam param){
        Context ctx = this.currentContext;
        
        do {
            if(param.type==InstructionParamType.INTLIT){
                return new MariObject(MariPrimitiveType.INT, param.value.literalValue);
            }
            else if(param.type==InstructionParamType.STRLIT){
                return new MariObject(MariPrimitiveType.STRING, param.value.literalValue);
            }
            else if(param.type==InstructionParamType.FLLIT){
                return new MariObject(MariPrimitiveType.FLOAT, param.value.literalValue);
            }
            else if(param.type==InstructionParamType.REGISTER){
                return ctx.getReg(param.value.registerAddress);
            }
            else if(param.type==InstructionParamType.VARNAME){
                foreach(string name; ctx.varTable.byKey()) {
                    if(name==param.value.varName){
                        return ctx.getVarValue(param.value.varName);
                    }
                }
            }

            ctx = ctx.getParent();
        } while (ctx !is null);
        return null; //this should probably be changed later, for better error handling
    }

    public void throwRuntimeException(string identifier, string information){
        auto builder = appender!string;
        builder.put("Runtime Exception: ");
        builder.put(this.currentContext.getIdentifier());
        builder.put(":");
        builder.put(identifier);
        builder.put(":");
        builder.put(to!string(this.currentContext.getIP()));
        builder.put(": ");
        builder.put(information);
        writeln(builder[]);
        this.errorStatus = true;
    }

}