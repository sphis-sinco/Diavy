package;

import flixel.addons.text.FlxTypeText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.exceptions.NotImplementedException;

enum DialoguePositionEnum
{
	BOTTOM;
	TOP;
}

class PlayState extends FlxState
{
	public static var instance:PlayState;

	public var preferences:
		{
			var dialoguePosition:DialoguePositionEnum;
		};

	public var dialogue:Array<String> = [];
	public var dialogue_progress:Int = 0;

	public var dialogue_box:FlxSprite;
	public var dialogue_text:FlxTypeText;

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
		initalizeDialogueText();

		beginDialogue();

		if (instance != null)
		{
			FlxG.log.warn('Another PlayState Instance detected. Reverting to null');
			instance = null;
		}

		instance = this;

		ScriptsManager.callScript('gameplay_create');
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		ScriptsManager.callScript('gameplay_update', [elapsed]);
	}

	public function beginDialogue()
	{
		dialogue_box.alpha = 0;
		dialogue_text.alpha = 0;
		dialogue_progress = 0;

		FlxTween.tween(dialogue_box, {alpha: 1}, 1, {
			ease: FlxEase.sineIn,
			onStart: tween ->
			{
				ScriptsManager.callScript('beginDialogue_dialogueBox_tweenStart', [dialogue_box]);
			},
			onUpdate: tween ->
			{
				ScriptsManager.callScript('beginDialogue_dialogueBox_tweenUpdate', [dialogue_box]);
			},
			onComplete: tween ->
			{
				ScriptsManager.callScript('beginDialogue_dialogueBox_tweenComplete', [dialogue_box]);
			}
		});
		FlxTween.tween(dialogue_text, {alpha: 1}, 1, {
			ease: FlxEase.sineIn,
			onStart: tween ->
			{
				ScriptsManager.callScript('beginDialogue_dialogueText_tweenStart', [dialogue_text]);
			},
			onUpdate: tween ->
			{
				ScriptsManager.callScript('beginDialogue_dialogueText_tweenUpdate', [dialogue_text]);
			},
			onComplete: tween ->
			{
				dialogue_text.start();
				ScriptsManager.callScript('beginDialogue_dialogueText_tweenComplete', [dialogue_text]);
			}
		});
		ScriptsManager.callScript('post_beginDialogue');
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

		ScriptsManager.callScript('post_initalizeDialogueBox', [dialogue_box]);
	}

	public function initalizeDialogueText()
	{
		if (dialogue_text == null)
		{
			dialogue_text = new FlxTypeText(0, 0, 0, 'Coolswag Coolswag', 16);
			addObject(dialogue_text);
		}

		dialogue_text.showCursor = true;
		dialogue_text.useDefaultSound = true;

		dialogue_text.fieldWidth = dialogue_box.width - 10;
		dialogue_text.color = FlxColor.BLACK;
		dialogue_text.setPosition(dialogue_box.x + 5, dialogue_box.y + 5);

		ScriptsManager.callScript('post_initalizeDialogueText', [dialogue_text]);
	}

	public function initalizePreferences()
	{
		preferences = {
			dialoguePosition: null
		};
		preferences.dialoguePosition ??= BOTTOM;

		ScriptsManager.callScript('post_initalizePreferences', [preferences]);
	}
}
