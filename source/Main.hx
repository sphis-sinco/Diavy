package;

import flixel.graphics.FlxGraphic;
import openfl.display.Sprite;
import play.defines.DefineManager;

class Main extends Sprite
{
	public static var gameRelease:Int = 9;

	public function new()
	{
		super();

		FlxModding.init();

		@:privateAccess {
			ScriptsManager.loadScripts();
		}

		FlxGraphic.defaultPersist = true;

		trace('Define list: ');
		for (define in DefineManager.DEFINE_LIST)
			trace('* ${define.name}: ${define.value()} (raw: ${define.raw_value()})');

		addChild(new FlxGame(0, 0, CachingState));
	}
}
