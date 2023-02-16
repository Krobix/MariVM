import std.string;
import std.conv;

//Implementation of objects, from primitives to complex objects with properties and methods

union MariPrimitiveValue {
    int intValue;
    float floatValue;
    string stringValue;
}

enum MariPrimitiveType {
    NONE = 0,
    NULLTYPE,
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

    this(MariPrimitiveType type, MariPrimitiveValue value){
        this.primitiveType = type;
        this.primitiveValue = value;
        this.isPrimitive = true;
    }

    public bool getIsPrimitive(){
        return this.isPrimitive;
    }
    
    public void setIsPrimitive(bool v) {
        this.isPrimitive = v;
    }

    public bool isPrimitiveType(MariPrimitiveType pt){
        return (pt==this.primitiveType);
    }

    public MariPrimitiveValue getPrimitiveValue(){
        return this.primitiveValue;
    }

    //Methods that are specifically for non-primitive objects

    public string[] getPropList(){
        return null; //will change when objects with properties are implemented
    }
    
    public MariObject getProp(string name){
        return null; //will change when objects with properties are implemented
    }
    
    public void setProp(string name, MariObject value){

    }

}