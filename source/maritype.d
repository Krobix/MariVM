import mariobject;

//Complex Object types

//Some basic builtin types - to be initialized in this()
MariType mariObjectType;
MariType mariClassType;
MariType mariFuncType;

static this(){
    mariClassType = new MariType([], []);
    
    mariObjectType = new MariType([], []);

    mariFuncType = new MariType([mariObjectType], []);
}

class MariType:MariObject {
    
    private MariType[] parents;
    private string[] classPropList;

    this(){
        super(mariClassType);
        this.parents = [];
        this.classPropList = [];
    }

    this(MariType[] parents, string[] propList){
        super(mariClassType);
        this.parents = parents;
        this.classPropList = propList;
    }

    public MariType[] getParents(){
        return this.parents;
    }

    public string[] getClassPropList(){
        return this.classPropList;
    }

}