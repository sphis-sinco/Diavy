package;

import flixel.animation.*;
import flixel.effects.FlxFlicker;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.*;
import flixel.group.*;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.keyboard.*;
import flixel.input.mouse.FlxMouse;
import flixel.math.*;
import flixel.text.*;
import flixel.tweens.*;
import flixel.util.*;
import flixel.util.typeLimit.NextState;
import haxe.PosInfos;
import play.*;
import play.dialogue.*;
import play.modules.*;
import play.modules.init.*;
import play.scripts.*;
import shaders.AdjustColorShader;
#if hscript
import hscript.*;
#end

// THANK YOU FNF-Doido-Engine
class ScriptsManager
{
	// hscript!!
	public static var LOADED_SCRIPTS:Array<Iris> = [];

	private static function loadScripts():Void
	{
		// NO DUPES
		for (instance in LOADED_SCRIPTS)
		{
			// fix multiple instances of similar scripts
			// trace('Bye bye ${instance.name}');
			instance.destroy();
		}
		LOADED_SCRIPTS = [];

		// loading scripts
		var scriptPaths:Array<String> = [];
		var readDirectory = function(dir:String) {}

		readDirectory = function(dir:String)
		{
			// trace(dir);
			if (!FileSystem.exists(dir))
				return;
			for (file in FileSystem.readDirectory(dir))
			{
				if (file.endsWith(Assets.HSCRIPT_EXT))
				{
					// trace(file);
					if (!scriptPaths.contains('$dir/$file') && !scriptPaths.contains('$file'))
						scriptPaths.push('$dir/$file');
					else
					{
						if (scriptPaths.contains(file))
							trace(file);
					}
				}
				else if (!file.contains('.'))
				{
					readDirectory('$dir/$file');
				}
			}
		}
		readDirectory(Assets.getAssetPath('scripts'));
		readDirectory('assets/scripts');

		for (path in scriptPaths)
		{
			var newScript:Iris = new Iris(File.getContent(path), {name: path, autoRun: true, autoPreset: true});
			if (LOADED_SCRIPTS.contains(newScript))
				return;
			// FlxG.log.add('New script: $path');
			LOADED_SCRIPTS.push(newScript);
		}

		// import stuff
		#if sys
		setScript('FileSystem', FileSystem);
		setScript('File', File);
		#end

		setScript('AdjustColorShader', AdjustColorShader);
		setScript('PlayState', PlayState);
		setScript('DialogueTextInitalizer', DialogueTextInitalizer);
		setScript('BlankState', BlankState);
		setScript('ModMenu', ModMenu);

		setScript('Assets', Assets);
		setScript('ScriptsManager', ScriptsManager);

		setScript("FlxG", FlxG);
		setScript("FlxGraphic", FlxGraphic);
		setScript("FlxSprite", FlxSprite);
		setScript("FlxObject", FlxObject);
		setScript("FlxBasic", FlxBasic);
		setScript("FlxState", FlxState);
		setScript("FlxCamera", FlxCamera);
		setScript("FlxGame", FlxGame);

		// Groups
		setScript("FlxGroup", flixel.group.FlxGroup);
		setScript("FlxContainer", FlxContainer);

		// Animation
		setScript("FlxAnimation", FlxAnimation);
		setScript("FlxAnimationController", FlxAnimationController);
		setScript("FlxAtlasFrames", FlxAtlasFrames);
		setScript("FlxTileFrames", FlxTileFrames);
		setScript("FlxFrame", FlxFrame);

		// Math
		setScript("FlxAngle", FlxAngle);
		setScript("FlxRect", FlxRect);
		setScript("FlxMath", FlxMath);
		setScript("FlxRandom", FlxRandom);

		// Text
		setScript("FlxText", FlxText);
		setScript("FlxInputText", FlxInputText);

		// Input
		setScript("FlxMouse", FlxMouse);
		setScript("FlxKeyboard", FlxKeyboard);
		setScript("FlxScriptKey", FlxScriptKey);
		setScript("FlxGamepad", FlxGamepad);

		// Utilities
		setScript("FlxSave", FlxSave);
		setScript("FlxTimer", FlxTimer);
		setScript("FlxSort", FlxSort);

		#if (!js || !html5)
		setScript("FlxModding", FlxModding);
		#end

		// Tweens
		setScript("FlxTween", FlxTween);
		setScript("FlxEase", FlxEase);

		// Effects
		setScript("FlxFlicker", FlxFlicker);

		// script exclusive stuff
		setScript('is_debug', #if debug true #else false #end);
		setScript('colorFromString', function(string:String)
		{
			return FlxColor.fromString(string);
		});
		setScript('switchState', function(nextState:NextState)
		{
			FlxG.switchState(nextState);
		});

		// init mod

		callScript('scriptsLoaded');
	}

	public static function callScript(fun:String, ?args:Array<Dynamic>, ?endCallBack:Void->Void, ?pos:haxe.PosInfos):Void
	{
		for (script in LOADED_SCRIPTS)
		{
			@:privateAccess {
				var ny:Dynamic = script.interp.variables.get(fun);
				try
				{
					if (ny != null && Reflect.isFunction(ny))
					{
						script.call(fun, args);
						// trace('ran $fun with args $args', pos);
					}
				}
				catch (e)
				{
					trace('error parsing script: ' + e, pos);
				}
			}
		}

		if (endCallBack != null)
			endCallBack();
	}

	public static function setScript(name:String, value:Dynamic, allowOverride:Bool = true):Void
	{
		for (script in LOADED_SCRIPTS)
			script.set(name, value, allowOverride);
	}
}
