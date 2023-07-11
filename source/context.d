import std.algorithm.mutation;
import std.conv;
import mariobject;

class Context {
    private int ip; //instruction pointer
    private string ctxIdentifier;
    private MariObject[10] registers;
    private int[string] varTable;
    private Context parentContext;

    this(string id){
        this.ctxIdentifier = id;
        this.parentContext = null;
        this.ip = 0;
    }

    this(string id, Context ctx){
        //this constructor is used to create a child Context
        this.ctxIdentifier = id;
        this.parentContext = ctx;
        this.ip = 0;
    }

    public void setReg(int index, MariObject value){
        this.registers[index] = value;
    }

    public MariObject getReg(int index){
        return this.registers[index];
    }

    public int getVarAddress(string name){
        return this.varTable[name];
    }

    public void setVar(string name, int address){
        this.varTable[name] = address;
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
}
