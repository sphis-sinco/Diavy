package;

class FileTypeTracer
{
	public static function traceFileTypes()
	{
		var imagePaths:Array<String> = [];
		var jsonPaths:Array<String> = [];
		var scriptPaths:Array<String> = [];
		var sfxPaths:Array<String> = [];
		var musicPaths:Array<String> = [];

		var readDirectory = function(dir:String, ext:String, array:Array<String>) {}

		readDirectory = function(dir:String, ext:String, array:Array<String>)
		{
			if (!FileSystem.exists(dir))
				return;
			for (file in FileSystem.readDirectory(dir))
			{
				if (file.endsWith(ext))
				{
					if (!array.contains('$dir/$file'))
						array.push('$dir/$file');
				}
				else if (!file.contains('.'))
					readDirectory('$dir/$file', ext, array);
			}
		}

		readDirectory('assets/data', '.json', jsonPaths);
		readDirectory('assets/scripts', Assets.HSCRIPT_EXT, scriptPaths);
		readDirectory('assets/images', Assets.IMAGE_EXT, imagePaths);
		readDirectory('assets/sounds', Assets.SOUND_EXT, sfxPaths);
		readDirectory('assets/music', Assets.SOUND_EXT, musicPaths);

		readDirectory(Assets.getAssetPath('data'), '.json', jsonPaths);
		readDirectory(Assets.getAssetPath('scripts'), Assets.HSCRIPT_EXT, scriptPaths);
		readDirectory(Assets.getAssetPath('images'), Assets.IMAGE_EXT, imagePaths);
		readDirectory(Assets.getAssetPath('sounds'), Assets.SOUND_EXT, sfxPaths);
		readDirectory(Assets.getAssetPath('music'), Assets.SOUND_EXT, musicPaths);

		trace('${jsonPaths.length} JSON files');
		trace('${imagePaths.length} Image files');
		trace('${scriptPaths.length} Script files');
		trace('${sfxPaths.length} Sound files');
		trace('${musicPaths.length} Music files');
	}
}
