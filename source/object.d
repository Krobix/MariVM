import std.string;
import std.conv;

union MariPrimitiveValue {
    int intValue;
    float flValue;
    string strValue;
}

enum MariPrimitiveType {
    NONE = 0,
    INT,
    FLOAT,
    STRING
}

class MariObject {

    private bool isPrimitive;
    private MariPrimitiveType primitiveType;
    private MariPrimitiveValue primitiveValue;

    //integer primitive constructor
    this(int value) {
        MariPrimitiveValue pv;
        this.primitiveType = MariPrimitiveType.INT;
        pv.intValue = value;
        this.primitiveValue = pv;
        this.isPrimitive = true;
    }

    //float primitive constructor
    this(float value){
        MariPrimitiveValue pv;
        this.primitiveType = MariPrimitiveType.FLOAT;
        pv.floatValue = value;
        this.primitiveValue = pv;
        this.isPrimitive = true;
    }

    //string primitive value
    this(string value){
        MariPrimitiveValue pv;
        this.primitiveType = MariPrimitiveType.STRING;
        pv.stringValue = value;
        this.primitiveValue = pv;
        this.isPrimitive = true;
    }

    public bool getIsPrimitive(){
        return this.isPrimitive;
    }
    public void setIsPrimitive(bool v) {
        this.isPrimitive = v;
    }

    //Methods that are specifically for non-primitive objects

    public string[] getPropList(){

    }
    
    public MariObject getProp(string name){

    }
    
    public void setProp(string name, MariObject value){

    }

}