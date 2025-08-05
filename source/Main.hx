package;

import flixel.graphics.FlxGraphic;
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

		FlxGraphic.defaultPersist = true;

		trace('STARTING_LINE: ' + Compiler.getDefine('STARTING_LINE'));

		addChild(new FlxGame(0, 0, ModMenu));
	}
}
