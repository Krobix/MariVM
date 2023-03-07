import std.algorithm.mutation;
import std.conv;
import mariobject;

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
        if(this.stack.length>0) return this.stack[$-1];
        else return null;
    }

    public void deleteFromStack(int index){
        this.stack = remove(this.stack, index);
        foreach(string name; this.varTable.byKey()){ //Changing variable addresses so taht they're correct after removal
            if(this.varTable[name]>index){
                this.varTable[name]--;
            }
        }
    }

    public void deleteFromTopOfStack(){
        if(this.stack.length>0) this.deleteFromStack(to!int(this.stack.length-1));
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

    public int[string] getVarTable(){
        return this.varTable;
    }

    public void deleteVar(string name){
        this.varTable.remove(name);
    }

    public int stackLen(){
        return to!int(this.stack.length);
    }
}
