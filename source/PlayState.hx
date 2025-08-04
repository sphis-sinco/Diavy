package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

enum DialoguePositionEnum
{
	BOTTOM;
	TOP;
}

class PlayState extends FlxState
{
	public var preferences:
		{
			var dialoguePosition:DialoguePositionEnum;
		};

	public var dialogue:Array<String> = [];
	public var dialogue_progress:Int = 0;

	public var dialogue_box:FlxSprite;

	public var addObject = function(object:FlxBasic) {};

	override public function create()
	{
		super.create();

		addObject = function(object:FlxBasic)
		{
			add(object);
		}

		dialogue = ['Hey!', 'Coolswag. Coolswag.'];

		initalizePreferences();
		initalizeDialogueBox();

		beginDialogue();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function beginDialogue()
	{
		dialogue_box.alpha = 0;
		dialogue_progress = 0;

		FlxTween.tween(dialogue_box, {alpha: 1}, 1, {
			ease: FlxEase.sineIn
		});
	}

	public function initalizeDialogueBox()
	{
		if (dialogue_box == null)
		{
			dialogue_box = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * .75), Std.int(FlxG.height * .25));
			dialogue_box.screenCenter(X);
			addObject(dialogue_box);
		}

		dialogue_box.y = FlxG.height - dialogue_box.height - 32;
		if (preferences.dialoguePosition == TOP)
			dialogue_box.y = dialogue_box.height * .25;
	}

	public function initalizePreferences()
	{
		preferences = {
			dialoguePosition: null
		};
		preferences.dialoguePosition ??= BOTTOM;
	}
}
