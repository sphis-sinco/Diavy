package play.modules;

import flixel.sound.FlxSound;

class ChoiceTextSounds
{
	public static function getList()
		return [
			new FlxSound().loadStream(Assets.getSoundPath('customType-1')),
			new FlxSound().loadStream(Assets.getSoundPath('customType-2')),
			new FlxSound().loadStream(Assets.getSoundPath('customType-3')),
			new FlxSound().loadStream(Assets.getSoundPath('customType-4'))
		];
}
