package play.defines;

class StartingLine extends DefineBase
{
	override public function new()
	{
		super('STARTING_LINE');
	}

	override function raw_value():String
	{
		return Compiler.getDefine('STARTING_LINE');
	}
}
