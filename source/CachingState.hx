package;

import flixel.graphics.FlxGraphic;

class CachingState extends FlxState
{
	public static var goToPlayState:Bool = false;

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
					// trace('$dir/$file');
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

		for (image in imagePaths)
		{
			cacheTexture(image);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	static var currentCachedTextures:Map<String, FlxGraphic> = [];
	static var previousCachedTextures:Map<String, FlxGraphic> = [];

	public static function cacheTexture(key:String):Void
	{
		var tpSplit:Array<String>;
		tpSplit = key.split('/');

		// We don't want to cache the same texture twice.
		if (currentCachedTextures.exists(key))
			return;

		if (previousCachedTextures.exists(key))
		{
			// Move the graphic from the previous cache to the current cache.
			var graphic = previousCachedTextures.get(key);
			previousCachedTextures.remove(key);
			currentCachedTextures.set(key, graphic);
			return;
		}

		// Else, texture is currently uncached.
		var graphic:FlxGraphic = FlxGraphic.fromAssetKey(key, false, null, true);
		var fail = graphic == null;
		if (fail)
		{
			FlxG.log.warn('Failed to cache graphic: $key');
		}
		else
		{
			trace('Successfully cached graphic: $key');
			graphic.persist = true;
			currentCachedTextures.set(key, graphic);
		}
	}

	/**
	 * Determine whether the texture with the given key is cached.
	 * @param key The key of the texture to check.
	 * @return Whether the texture is cached.
	 */
	public static function isTextureCached(key:String):Bool
	{
		return FlxG.bitmap.get(key) != null;
	}

	/**
	 * Call this, then `cacheTexture` to keep the textures we still need, then `purgeCache` to remove the textures that we won't be using anymore.
	 */
	public static function preparePurgeCache():Void
	{
		previousCachedTextures = currentCachedTextures;
		currentCachedTextures = [];
	}

	public static function purgeCache():Void
	{
		// Everything that is in previousCachedTextures but not in currentCachedTextures should be destroyed.
		for (graphicKey in previousCachedTextures.keys())
		{
			var graphic = previousCachedTextures.get(graphicKey);
			if (graphic == null)
				continue;
			FlxG.bitmap.remove(graphic);
			graphic.destroy();
			previousCachedTextures.remove(graphicKey);
		}
	}
}
