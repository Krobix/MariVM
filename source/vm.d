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
        if(!(x.isPrimitiveType(MariPrimitiveType.INT) && y.isPrimitiveType(MariPrimitiveType.INT))) {
            this.throwRuntimeException("TypeError", "INTADD instruction requires two integers");
        }
        else {
            int prod = x.getPrimitiveValue().intValue + y.getPrimitiveValue().intValue;
            MariObject output = new MariObject(prod);
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
        writeln(builder[]);
        this.errorStatus = true;
    }

}