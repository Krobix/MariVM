import mariobject;

//Complex Object types

//Some basic builtin types - to be initialized in this()
MariType mariObjectType;
MariType mariClassType;
MariType mariFuncType;

this(){
    mariClassType = new MariType([], []);
    
    mariObjectType = new MariType([], []);

    mariFuncType = new MariType([mariObjectType], []);
}

class MariType:MariObject {
    
    private MariType[] parents;
    private string[] propList;

    this(MariType[] parents, string[] propList){
        this.parents = parents;
        this.propList = propList;
    }

    public MariType[] getParents(){
        return this.parents;
    }

    public string[] getPropList(){
        return this.propList;
    }

}