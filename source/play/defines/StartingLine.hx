package play.defines;

class StartingLine extends DefineBase
{
	override public function new()
	{
		super('STARTING_LINE');
	}

	override function value():String
		return Compiler.getDefine('STARTING_LINE').split('=')[0];
}
