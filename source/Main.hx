package;

import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		FlxModding.init();

		@:privateAccess {
			ScriptsManager.loadScripts();
		}

		addChild(new FlxGame(0, 0, PlayState));
	}
}
