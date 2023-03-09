import std.stdio;
import std.file;
import compiler;
import vm;
import instruction;

void main(string[] args)
{
	VM vm;
	Instruction[] code;
	string filename, rawText;
	if(args.length==1){
		writeln("USAGE: " ~ args[0] ~ " [filename]");
	}
	else {
		filename = args[1];
		rawText = readText(filename);
		code = compileFromString(rawText);
		vm = new VM(code);
	}
}
