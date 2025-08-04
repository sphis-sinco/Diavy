package;

import flixel.addons.text.FlxTypeText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import play.dialogue.*;
import play.modules.DialogueBoxInitalizer;
import play.modules.DialogueProceedIconInitalizer;
import play.modules.DialogueTextInitalizer;

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

	public var dialogue_text_typing_complete:Bool = false;

	public var dialogue_proceed_icon:FlxSprite;

	public var addObject = function(object:FlxBasic) {};

	override public function create()
	{
		super.create();

		if (instance != null)
		{
			FlxG.log.warn('Another PlayState Instance detected. Reverting to null');
			instance = null;
		}

		instance = this;

		addObject = function(object:FlxBasic)
		{
			add(object);
		}

		dialogue = ['Hey!', 'Coolswag. Coolswag.'];

		initalizePreferences();

		initalizeDialogueBox();
		initalizeDialogueText();

		beginDialogue();

		ScriptsManager.callScript('gameplay_create');
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (dialogue_text_typing_complete)
		{
			if (FlxG.keys.justReleased.ENTER)
			{
				nextDialogue();
			}
		}

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
				beginDialogueTyping();
				ScriptsManager.callScript('beginDialogue_dialogueText_tweenComplete', [dialogue_text]);
			}
		});
		ScriptsManager.callScript('beginDialogue');
	}

	public function initalizeDialogueBox()
	{
		dialogue_box = new DialogueBoxInitalizer(dialogue_box, preferences.dialoguePosition).getValues();
		dialogue_proceed_icon = new DialogueProceedIconInitalizer(dialogue_box, dialogue_proceed_icon).getValues();

		ScriptsManager.callScript('initalizeDialogueBox', [dialogue_box]);
	}

	public function initalizeDialogueText()
	{
		dialogue_text = new DialogueTextInitalizer(dialogue_box, dialogue_proceed_icon, dialogue_text).getValues();

		ScriptsManager.callScript('initalizeDialogueText', [dialogue_text]);
	}

	public function initalizePreferences()
	{
		preferences = {
			dialoguePosition: null
		};
		preferences.dialoguePosition ??= BOTTOM;

		ScriptsManager.callScript('initalizePreferences', [preferences]);
	}

	public function nextDialogue()
	{
		dialogue_progress++;

		if (dialogue_progress >= dialogue.length)
		{
			dialogue_progress--;
			return;
		}

		beginDialogueTyping();

		ScriptsManager.callScript('nextDialogue', [preferences]);
	}

	public function beginDialogueTyping()
	{
		dialogue_text.start();

		ScriptsManager.callScript('beginDialogueTyping', [preferences]);
	}
}
