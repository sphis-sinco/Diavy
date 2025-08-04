package;

import flixel.FlxState;

class PlayState extends FlxState
{
	public var dialogue:Array<String> = ["Hey!", "Coolswag. Coolswag."];
	public var dialogue_progress:Int = 0;

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
