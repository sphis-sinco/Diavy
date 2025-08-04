package;

import flixel.addons.text.FlxTypeText;
import flixel.tweens.*;
import play.dialogue.*;
import play.modules.init.*;

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

	public var scriptEventNames = {
		create: 'gameplay_create',
		update: 'gameplay_update',
		beginDialogue: 'beginDialogue',
		dialogueBoxInit_tweenStart: 'beginDialogue_dialogueBox_tweenStart',
		dialogueBoxInit_tweenUpdate: 'beginDialogue_dialogueBox_tweenUpdate',
		dialogueBoxInit_tweenComplete: 'beginDialogue_dialogueBox_tweenComplete',
		dialogueTextInit_tweenStart: 'beginDialogue_dialogueText_tweenStart',
		dialogueTextInit_tweenUpdate: 'beginDialogue_dialogueText_tweenUpdate',
		dialogueTextInit_tweenComplete: 'beginDialogue_dialogueText_tweenComplete',
		dialogueBoxInit: 'initalizeDialogueBox',
		dialogueTextInit: 'initalizeDialogueText',
		preferencesInit: 'initalizePreferences',
		nextDialogue: 'nextDialogue',
		beginDialogueTyping: 'beginDialogueTyping',
	};

	public var dialogue_end_callback:Void->Void;

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

		ScriptsManager.callScript(scriptEventNames.create);
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

		ScriptsManager.callScript(scriptEventNames.update, [elapsed]);
	}

	public function beginDialogue()
	{
		dialogue_box.alpha = 0;
		dialogue_text.alpha = 0;
		dialogue_progress = 0;

		FlxTween.tween(dialogue_box, {alpha: 1}, 1, {
			ease: FlxEase.sineIn,
			onStart: tween -> ScriptsManager.callScript(scriptEventNames.dialogueBoxInit_tweenStart, [dialogue_box]),
			onUpdate: tween -> ScriptsManager.callScript(scriptEventNames.dialogueBoxInit_tweenUpdate, [dialogue_box]),
			onComplete: tween -> ScriptsManager.callScript(scriptEventNames.dialogueBoxInit_tweenComplete, [dialogue_box])
		});
		FlxTween.tween(dialogue_text, {alpha: 1}, 1, {
			ease: FlxEase.sineIn,
			onStart: tween -> ScriptsManager.callScript(scriptEventNames.dialogueTextInit_tweenStart, [dialogue_text]),
			onUpdate: tween -> ScriptsManager.callScript(scriptEventNames.dialogueTextInit_tweenUpdate, [dialogue_text]),
			onComplete: tween ->
			{
				beginDialogueTyping();
				ScriptsManager.callScript(scriptEventNames.dialogueTextInit_tweenComplete, [dialogue_text]);
			}
		});
		ScriptsManager.callScript(scriptEventNames.beginDialogue);
	}

	public function initalizeDialogueBox()
	{
		dialogue_box = new DialogueBoxInitalizer(dialogue_box, preferences.dialoguePosition).getValues();
		dialogue_proceed_icon = new DialogueProceedIconInitalizer(dialogue_box, dialogue_proceed_icon).getValues();

		ScriptsManager.callScript(scriptEventNames.dialogueBoxInit, [dialogue_box]);
	}

	public function initalizeDialogueText()
	{
		dialogue_text = new DialogueTextInitalizer(dialogue_box, dialogue_proceed_icon, dialogue_text).getValues();

		ScriptsManager.callScript(scriptEventNames.dialogueTextInit, [dialogue_text]);
	}

	public function initalizePreferences()
	{
		preferences = {
			dialoguePosition: null
		};
		preferences.dialoguePosition ??= BOTTOM;

		ScriptsManager.callScript(scriptEventNames.preferencesInit, [preferences]);
	}

	public function nextDialogue()
	{
		dialogue_progress++;

		if (dialogue_progress >= dialogue.length)
		{
			dialogue_progress--;
			if (dialogue_end_callback != null)
				dialogue_end_callback();
			else
			{
				trace('End');
				Sys.exit(127);
			}
		}

		beginDialogueTyping();

		ScriptsManager.callScript(scriptEventNames.nextDialogue, [preferences]);
	}

	public function beginDialogueTyping()
	{
		dialogue_text.start(dialogue[dialogue_progress]);

		ScriptsManager.callScript(scriptEventNames.beginDialogueTyping, [preferences]);
	}
}
