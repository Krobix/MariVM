import std.string;
import std.conv;

enum MariPrimitiveType {
    
}

class MariObject {

    private bool primitive;
    private int primitiveIntValue;
    private float primitiveFlValue;
    private string primitiveStrValue;

    public bool isPrimitive(){
        return primitive;
    }
    public void setPrimitive(bool v) {
        this.primitive = v;
    }

    //Methods that are specifically for non-primitive objects

    public string[] getPropList(){

    }
    
    public MariObject getProp(string name){

    }
    
    public void setProp(string name, MariObject value){

    }

}