import std.string;
import std.algorithm.mutation;
import std.conv;
import instruction;
import mariobject;

//VM implementation

class Context {
    private MariObject[10] registers;
    private MariObject[] stack;
    private int[string] varTable;
    private Context parentContext;

    this(){
        this.stack = new MariObject[1];
        this.parentContext = null;
    }

    this(Context ctx){
        //this constructor is used to create a child Context
        this.stack = new MariObject[1];
        this.parentContext = ctx;
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
}

class VM {

    private int ip; //instruction pointer
    private Instruction[] code;
    private Context rootContext;
    private Context currentContext;

    this(Instruction[] code){
        this.code = code;
        this.rootContext = new Context();
        this.currentContext = this.rootContext;
        this.ip = 0;
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

}