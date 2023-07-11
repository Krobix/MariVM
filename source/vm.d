import std.string;
import std.algorithm.mutation;
import std.conv;
import std.stdio;
import std.array;
import instruction;
import mariobject;
import context;

//VM implementation

class VM {

    private bool errorStatus;
    private Instruction[] code;
    private MariObject[] stack;
    private Context rootContext;
    private Context currentContext;

    //start of vm operation methods

    private void instIntAdd(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output;
        if(!(x.isPrimitiveType(MariPrimitiveType.INT) && y.isPrimitiveType(MariPrimitiveType.INT))) {
            this.throwRuntimeException("TypeError", "INTADD instruction requires two integers");
        }
        else {
            int prod = x.getPrimitiveValue().intValue + y.getPrimitiveValue().intValue;
            output = new MariObject(prod);
            this.currentContext.setReg(0, output);
        }
    }

    private void instIntSub(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output; 
        if(!(x.isPrimitiveType(MariPrimitiveType.INT) && y.isPrimitiveType(MariPrimitiveType.INT))) {
            this.throwRuntimeException("TypeError", "INTSUB instruction requires two integers");
        }
        else {
            int prod = x.getPrimitiveValue().intValue - y.getPrimitiveValue().intValue;
            output = new MariObject(prod);
            this.currentContext.setReg(0, output);
        }
    }

    private void instIntMul(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output;
        if(!(x.isPrimitiveType(MariPrimitiveType.INT) && y.isPrimitiveType(MariPrimitiveType.INT))) {
            this.throwRuntimeException("TypeError", "INTMUL instruction requires two integers");
        }
        else {
            int prod = x.getPrimitiveValue().intValue * y.getPrimitiveValue().intValue;
            output = new MariObject(prod);
            this.currentContext.setReg(0, output);
        }
    }

    private void instIntDiv(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output;
        if(!(x.isPrimitiveType(MariPrimitiveType.INT) && y.isPrimitiveType(MariPrimitiveType.INT))) {
            this.throwRuntimeException("TypeError", "INTDIV instruction requires two integers");
        }
        else {
            int prod = x.getPrimitiveValue().intValue / y.getPrimitiveValue().intValue;
            output = new MariObject(prod);
            this.currentContext.setReg(0, output);
        }
    }

    private void instIntMod(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output;
        if(!(x.isPrimitiveType(MariPrimitiveType.INT) && y.isPrimitiveType(MariPrimitiveType.INT))) {
            this.throwRuntimeException("TypeError", "INTMOD instruction requires two integers");
        }
        else {
            int prod = x.getPrimitiveValue().intValue % y.getPrimitiveValue().intValue;
            output = new MariObject(prod);
            this.currentContext.setReg(0, output);
        }
    }

    private void instFlAdd(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output;
        if(!(x.isPrimitiveType(MariPrimitiveType.FLOAT) && y.isPrimitiveType(MariPrimitiveType.FLOAT))) {
            this.throwRuntimeException("TypeError", "FLADD instruction requires two floats");
        }
        else {
            float prod = x.getPrimitiveValue().floatValue + y.getPrimitiveValue().floatValue;
            output = new MariObject(prod);
            this.currentContext.setReg(0, output);
        }
    }

    private void instFlSub(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output;
        if(!(x.isPrimitiveType(MariPrimitiveType.FLOAT) && y.isPrimitiveType(MariPrimitiveType.FLOAT))) {
            this.throwRuntimeException("TypeError", "FLSUB instruction requires two floats");
        }
        else {
            float prod = x.getPrimitiveValue().floatValue - y.getPrimitiveValue().floatValue;
            output = new MariObject(prod);
            this.currentContext.setReg(0, output);
        }
    }

    private void instFlMul(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output;
        if(!(x.isPrimitiveType(MariPrimitiveType.FLOAT) && y.isPrimitiveType(MariPrimitiveType.FLOAT))) {
            this.throwRuntimeException("TypeError", "FLMUL instruction requires two floats");
        }
        else {
            float prod = x.getPrimitiveValue().floatValue * y.getPrimitiveValue().floatValue;
            output = new MariObject(prod);
            this.currentContext.setReg(0, output);
        }
    }

    private void instFlDiv(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output;
        if(!(x.isPrimitiveType(MariPrimitiveType.FLOAT) && y.isPrimitiveType(MariPrimitiveType.FLOAT))) {
            this.throwRuntimeException("TypeError", "FLDIV instruction requires two floats");
        }
        else {
            float prod = x.getPrimitiveValue().floatValue / y.getPrimitiveValue().floatValue;
            output = new MariObject(prod);
            this.currentContext.setReg(0, output);
        }
    }

    private void instStrAdd(InstructionParam[] params){
        MariObject x = this.instructionParamToObject(params[0]);
        MariObject y = this.instructionParamToObject(params[1]);
        MariObject output;
        if(!(x.isPrimitiveType(MariPrimitiveType.STRING) && y.isPrimitiveType(MariPrimitiveType.STRING))) {
            this.throwRuntimeException("TypeError", "STRADD instruction requires two strings");
        }
        else {
            auto builder = appender!string;
            builder.put(x.getPrimitiveValue().stringValue);
            builder.put(y.getPrimitiveValue().stringValue);
            output = new MariObject(builder.toString());
            this.currentContext.setReg(0, output);
        }
    }

    private void instIntNew(InstructionParam[] params){
        MariObject val = this.instructionParamToObject(params[0]);
        MariObject output;
        if(!val.isPrimitiveType(MariPrimitiveType.INT)){
            this.throwRuntimeException("TypeError", "INTNEW instruction requires an integer");
        }
        else {
            output = new MariObject(val.getPrimitiveValue().intValue);
            this.currentContext.setReg(0, output);
        }
    }

    private void instFlNew(InstructionParam[] params){
        MariObject val = this.instructionParamToObject(params[0]);
        MariObject output;
        if(!val.isPrimitiveType(MariPrimitiveType.FLOAT)){
            this.throwRuntimeException("TypeError", "FLNEW instruction requires a float");
        }
        else {
            output = new MariObject(val.getPrimitiveValue().floatValue);
            this.currentContext.setReg(0, output);
        }
    }

    private void instStrNew(InstructionParam[] params){
        MariObject val = this.instructionParamToObject(params[0]);
        MariObject output;
        if(!val.isPrimitiveType(MariPrimitiveType.STRING)){
            this.throwRuntimeException("TypeError", "STRNEW instruction requires a string");
        }
        else {
            output = new MariObject(val.getPrimitiveValue().stringValue);
            this.currentContext.setReg(0, output);
        }
    }

    private void instLog(InstructionParam[] params){
        MariObject val = this.instructionParamToObject(params[0]);
        string s;
        if(!val.isPrimitiveType(MariPrimitiveType.STRING)){
            this.throwRuntimeException("TypeError", "LOG instruction requires a string");
        }
        else{
            s = val.getPrimitiveValue().stringValue;
            writeln(s);
        }
    }

    private void instStore(InstructionParam[] params){
        MariObject val;
        if(params[0].type != InstructionParamType.REGISTER){
            this.throwRuntimeException("RuntimeError", "STORE instruction must be given register name as parameter");
        }
        else {
            val = this.instructionParamToObject(params[0]);
            this.pushToStack(val);
        }
    }

    private void instLoad(InstructionParam[] params){
        MariObject val;
        if(!(params.length==2 && params[1].type==InstructionParamType.REGISTER)){
            this.throwRuntimeException("RuntimeError", "LOAD instruction requires exactly two arguments, the second of which must be a register.");
        }
        else {
            val = this.instructionParamToObject(params[0]);
            this.currentContext.setReg(params[1].value.registerAddress, val);
        }
    }

    private void instDefVar(InstructionParam[] params){
        MariObject val;
        if(!(params.length==2 && params[0].type==InstructionParamType.VARNAME)){
            this.throwRuntimeException("RuntimeError", "DEFVAR instruction requires exactly two arguments, the first of which must be a valid identifier.");
        }
        else {
            val = this.instructionParamToObject(params[1]);
            this.pushToStack(val);
            this.currentContext.setVar(params[0].value.varName, this.stack.length-1);
        }
    }

    private void instDelete(InstructionParam[] params){
        string varName;
        if(!(params[0].type==InstructionParamType.VARNAME)){
            this.throwRuntimeException("RuntimeError", "DELETE instruction must be given variable name as parameter");
        }
        else {
            varName = params[0].value.varName;
            this.currentContext.deleteVar(varName);
        }
    }

    private void instFree(InstructionParam[] params){
        int ind;
        string varName;
        if(!(params[0].type==InstructionParamType.VARNAME)){
            this.throwRuntimeException("RuntimeError", "FREE instruction must be given variable name as parameter");
        }
        else {
            varName = params[0].value.varName;
            ind = this.currentContext.getVarAddress(varName);
            this.currentContext.deleteVar(varName);
            this.deleteFromStack(ind);
        }
    }

    private void instPop(InstructionParam[] params){
        MariObject val = this.currentContext.getFromTopOfStack();
        if(val is null){
            this.throwRuntimeException("RuntimeError", "Cannot complete POP instruction when stack length is zero");
        }
        else {
            this.currentContext.deleteFromTopOfStack();
            this.currentContext.setReg(0, val);
        }
    }

    private void instIntToStr(InstructionParam[] params){
        MariObject val = this.instructionParamToObject(params[0]);
        string output;
        if((val is null) || (!(val.isPrimitiveType(MariPrimitiveType.INT)))){
            this.throwRuntimeException("TypeError", "Parameter given to INTTOSTR instruction must be integer");
        }
        else {
            output = to!string(val.getPrimitiveValue().intValue);
            this.currentContext.setReg(0, new MariObject(output));
        }
    }

    private void instFlToStr(InstructionParam[] params){
        MariObject val = this.instructionParamToObject(params[0]);
        string output;
        if((val is null) || (!(val.isPrimitiveType(MariPrimitiveType.FLOAT)))){
            this.throwRuntimeException("TypeError", "Parameter given to FLTOSTR instruction must be float");
        }
        else {
            output = to!string(val.getPrimitiveValue().floatValue);
            this.currentContext.setReg(0, new MariObject(output));
        }
    }

    private void instStrToInt(InstructionParam[] params){
        MariObject val = this.instructionParamToObject(params[0]);
        int output;
        if((val is null) || (!(val.isPrimitiveType(MariPrimitiveType.STRING)))){
            this.throwRuntimeException("TypeError", "Parameter given to STRTOINT instruction must be string");
        }
        else {
            output = to!int(val.getPrimitiveValue().stringValue);
            this.currentContext.setReg(0, new MariObject(output));
        }
    }

    private void instStrToFl(InstructionParam[] params){
        MariObject val = this.instructionParamToObject(params[0]);
        float output;
        if((val is null) || (!(val.isPrimitiveType(MariPrimitiveType.STRING)))){
            this.throwRuntimeException("TypeError", "Parameter given to STRTOFL instruction must be string");
        }
        else {
            output = to!float(val.getPrimitiveValue().stringValue);
            this.currentContext.setReg(0, new MariObject(output));
        }
    }


    //-----------------------------

    this(Instruction[] code){
        this.code = code;
        this.rootContext = new Context("rootContext");
        this.currentContext = this.rootContext;
        this.errorStatus = false;

        debug {
            writeln("[DEBUG] Created VM object");
        }
    }

    public void execInstruction(Instruction instruction){
        
        debug {
            writeln("[DEBUG] Executing instruction: OP=" ~ to!string(instruction.op));
        }
        
        switch(instruction.op){
            case Opcode.INTADD:
                this.instIntAdd(instruction.params);
                break;
            case Opcode.INTSUB:
                this.instIntSub(instruction.params);
                break;
            case Opcode.INTMUL:
                this.instIntMul(instruction.params);
                break;
            case Opcode.INTDIV:
                this.instIntDiv(instruction.params);
                break;
            case Opcode.FLADD:
                this.instFlAdd(instruction.params);
                break;
            case Opcode.FLSUB:
                this.instFlSub(instruction.params);
                break;
            case Opcode.FLMUL:
                this.instFlMul(instruction.params);
                break;
            case Opcode.FLDIV:
                this.instFlDiv(instruction.params);
                break;
            case Opcode.STRADD:
                this.instStrAdd(instruction.params);
                break;
            case Opcode.INTNEW:
                this.instIntNew(instruction.params);
                break;
            case Opcode.FLNEW:
                this.instFlNew(instruction.params);
                break;
            case Opcode.STRNEW:
                this.instStrNew(instruction.params);
                break;
            case Opcode.LOG:
                this.instLog(instruction.params);
                break;
            case Opcode.STORE:
                this.instStore(instruction.params);
                break;
            case Opcode.LOAD:
                this.instLoad(instruction.params);
                break;
            case Opcode.DEFVAR:
                this.instDefVar(instruction.params);
                break;
            case Opcode.DELETE:
                this.instDelete(instruction.params);
                break;
            case Opcode.FREE:
                this.instFree(instruction.params);
                break;
            case Opcode.POP:
                this.instPop(instruction.params);
                break;
            case Opcode.INTTOSTR:
                this.instIntToStr(instruction.params);
                break;
            case Opcode.FLTOSTR:
                this.instFlToStr(instruction.params);
                break;
            case Opcode.STRTOINT:
                this.instStrToInt(instruction.params);
                break;
            case Opcode.STRTOFL:
                this.instStrToFl(instruction.params);
                break;
            
            default: break;
        }
    }

    public void cpu(){
        int ip = this.currentContext.getIP();
        while(ip<this.code.length && !this.errorStatus){
            this.execInstruction(this.code[ip]);
            ip = this.currentContext.incrementIP();
        }
    }

    public MariObject getVarValue(string varName){
        Context ctx = this.currentContext;
        do {
            foreach(string name; ctx.getVarTable().byKey()) {
                    if(name==varName){
                        return this.stack[ctx.getVarAddress(varName)];
                    }
                }
        } while(ctx !is null);

        return null; // probably should change this later
    }

    private void deleteFromTopOfStack(){
        if(this.stack.length>0) this.deleteFromStack(to!int(this.stack.length-1));
    }

    private void deleteFromStack(int index){
        this.stack = remove(this.stack, index);
        foreach(string name; this.varTable.byKey()){ //Changing variable addresses so taht they're correct after removal
            if(this.varTable[name]>index){
                this.varTable[name]--;
            }
        }
    }

    private int stackLen(){
        return to!int(this.stack.length);
    }

    private void pushToStack(MariObject obj){
        this.stack ~= obj;
    }

    private 
    
    public MariObject instructionParamToObject(InstructionParam param){
        Context ctx = this.currentContext;

        debug {
            writeln("[DEBUG] instructionParamToObject(): TYPE=" ~ to!string(param.type));
        }
        
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
            return this.getVarValue(param.value.varName);
        }
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
        writeln(builder.toString());
        this.errorStatus = true;
    }

}