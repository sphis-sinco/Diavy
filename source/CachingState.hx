package;

class CachingState extends FlxState
{
	override function create()
	{
		var imagePaths:Array<String> = [];
		var readDirectory = function(dir:String) {}

		readDirectory = function(dir:String)
		{
			if (!FileSystem.exists(dir))
				return;
			for (file in FileSystem.readDirectory(dir))
			{
				if (file.endsWith(Assets.IMAGE_EXT))
				{
					trace('$dir/$file');
					if (!imagePaths.contains('$dir/$file'))
						imagePaths.push('$dir/$file');
				}
				else if (!file.contains('.'))
				{
					readDirectory('$dir/$file');
				}
			}
		}
		readDirectory('assets/images');
		readDirectory(Assets.getAssetPath('images'));

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
