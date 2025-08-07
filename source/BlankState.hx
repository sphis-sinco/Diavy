package;

class BlankState extends FlxState
{
	override function create()
	{
		super.create();
		ScriptsManager.callScript('blank_create');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		ScriptsManager.callScript('blank_update');
	}
}
