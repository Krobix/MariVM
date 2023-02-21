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


    //-----------------------------

    this(Instruction[] code){
        this.code = code;
        this.rootContext = new Context("rootContext");
        this.currentContext = this.rootContext;
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
                foreach(string name; ctx.getVarTable().byKey()) {
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
        writeln(builder.toString());
        this.errorStatus = true;
    }

}