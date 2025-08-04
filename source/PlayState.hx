package;

import flixel.addons.text.FlxTypeText;
import flixel.input.keyboard.FlxKey;
import flixel.sound.FlxSound;
import flixel.tweens.*;
import flixel.util.FlxTimer;
import play.*;
import play.dialogue.*;
import play.modules.init.*;

class PlayState extends FlxState
{
	public var dialogue:Array<DialogueEntry> = [];

	public static var instance:PlayState;

	public var preferences:PlayStatePreferences;

	public var dialogue_progress:Int = 0;

	public var dialogue_box:FlxSprite;
	public var dialogue_text:FlxTypeText;
	public var choice_text:FlxTypeText = new FlxTypeText(0, 0, 0, '', 16);

	public var dialogue_text_typing_complete:Bool = false;

	public var dialogue_proceed_icon:FlxSprite;

	public var scriptEventNames = {
		create: 'gameplay_create',
		setdialogue: 'gameplay_setDialogue',
		update: 'gameplay_update',
		beginDialogue: 'beginDialogue',
		dialogueBoxInit_tweenStart: 'beginDialogue_dialogueBox_tweenStart',
		dialogueBoxInit_tweenUpdate: 'beginDialogue_dialogueBox_tweenUpdate',
		dialogueBoxInit_tweenComplete: 'beginDialogue_dialogueBox_tweenComplete',
		dialogueTextInit_tweenStart: 'beginDialogue_dialogueText_tweenStart',
		dialogueTextInit_tweenUpdate: 'beginDialogue_dialogueText_tweenUpdate',
		dialogueTextInit_tweenComplete: 'beginDialogue_dialogueText_tweenComplete',
		dialogueCharacterInit: 'initalizeDialogueCharacter',
		dialogueBoxInit: 'initalizeDialogueBox',
		dialogueTextInit: 'initalizeDialogueText',
		preferencesInit: 'initalizePreferences',
		nextDialogue: 'nextDialogue',
		beginDialogueTyping: 'beginDialogueTyping',
	};

	public var dialogue_end_callback:Void->Void;

	public var addObject = function(object:FlxBasic) {};

	public var dialogue_character:FlxSprite;

	public var addDialogue = function(dia:DialogueEntry) {};
	public var addDialogueArray = function(diaList:Array<DialogueEntry>) {};
	public var removeDialogueLine = function(dia:String) {};
	public var deleteAllDialogue = function() {};

	override public function create()
	{
		super.create();

		if (instance != null)
		{
			FlxG.log.warn('Another PlayState Instance detected. Reverting to null');
			instance = null;
		}

		instance = this;

		can_press_enter = true;

		addObject = function(object:FlxBasic)
		{
			add(object);
		}

		addDialogue = function(dia:DialogueEntry)
		{
			this.dialogue.push(dia);
		};
		addDialogueArray = function(diaList:Array<DialogueEntry>)
		{
			for (dia in diaList)
				this.dialogue.push(dia);
		};
		removeDialogueLine = function(targettedDia:String)
		{
			for (dia in dialogue)
			{
				if (dia.line == targettedDia)
				{
					dialogue.remove(dia);
				}
			}
		};
		deleteAllDialogue = function()
		{
			dialogue = [];
		};

		dialogue = [
			{
				line: 'Yo!'
			},
			{
				line: 'Coolswag Coolswag'
			}
		];
		ScriptsManager.callScript(scriptEventNames.setdialogue);

		for (dialogueEntry in dialogue)
		{
			dialogueEntry.line ??= 'Null Entry';
			dialogueEntry.choices ??= [];
			dialogueEntry.character ??= 'sphisSinco';
		}

		initalizePreferences();

		initalizeDialogueCharacter();
		initalizeDialogueBox();
		initalizeDialogueText();

		beginDialogue();

		choice_text.y = 10;
		choice_text.alignment = CENTER;
		choice_text.sounds = [
			new FlxSound().loadStream(Assets.getSoundPath('customType-1')),
			new FlxSound().loadStream(Assets.getSoundPath('customType-2')),
			new FlxSound().loadStream(Assets.getSoundPath('customType-3')),
			new FlxSound().loadStream(Assets.getSoundPath('customType-4'))
		];
		addObject(choice_text);

		ScriptsManager.callScript(scriptEventNames.create);
	}

	public var can_press_enter:Bool = false;
	public var choices_keys:Array<FlxKey> = [];
	public var choices_events:Array<String> = [];

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		choice_text.screenCenter(X);

		if (dialogue_text_typing_complete)
		{
			if (FlxG.keys.justReleased.ENTER && can_press_enter)
				nextDialogue();

			if (dialogue[dialogue_progress].choices != null)
				if (dialogue[dialogue_progress].choices.length > 0)
				{
					if (FlxG.keys.anyJustReleased(choices_keys))
					{
						var i = 0;
						for (key in choices_keys)
						{
							if (FlxG.keys.anyJustReleased([key]))
								ScriptsManager.callScript(choices_events[i], [], () ->
								{
									nextDialogue();
								});
							i++;
						}
					}
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

	public function initalizeDialogueCharacter()
	{
		dialogue_character = new DialogueCharacterInitalizer(dialogue_character).getValues();

		ScriptsManager.callScript(scriptEventNames.dialogueCharacterInit, [dialogue_character]);
	}

	public function initalizeDialogueBox()
	{
		dialogue_box = new DialogueBoxInitalizer(dialogue_box, preferences.dialoguePosition).getValues();
		dialogue_proceed_icon = new DialogueProceedIconInitalizer(dialogue_box, dialogue_proceed_icon).getValues();

		ScriptsManager.callScript(scriptEventNames.dialogueBoxInit, [dialogue_box]);
	}

	public function initalizeDialogueText()
	{
		dialogue_text = new DialogueTextInitalizer(dialogue_text).getValues();

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

		initalizeDialogueCharacter();

		ScriptsManager.callScript(scriptEventNames.nextDialogue);
	}

	public var dialogueLine = '';
	public var controlsLine = 'Controls:\n\nENTER - CONTINUE\n';

	public function beginDialogueTyping()
	{
		choice_text.resetText('');
		dialogue_text.resetText('');
		try
		{
			choices_keys = [];
			choices_events = [];
			dialogueLine = dialogue[dialogue_progress].line;
			controlsLine = 'Controls:\n\nENTER - CONTINUE\n';

			if (dialogue[dialogue_progress].choices != null)
				if (dialogue[dialogue_progress].choices.length > 0)
				{
					controlsLine = 'Controls:\n\n';
					for (choice in dialogue[dialogue_progress].choices)
					{
						choices_keys.push(choices_keys_map.get(choice.keyString.toUpperCase()));
						choices_events.push(choice.script_event);

						controlsLine += '${choice.keyString} - ${choice.name}\n';
					}
				}

			dialogue_text.start(dialogueLine, 0.05, false, false, []);
		}
		catch (e)
		{
			dialogue_text.start(e.message);
		}

		ScriptsManager.callScript(scriptEventNames.beginDialogueTyping);
	}

	public var choices_keys_map:Map<String, FlxKey> = [
		// Letters
		'A' => A,
		'B' => B,
		'C' => C,
		'D' => D,
		'E' => E,
		'F' => F,
		'G' => G,
		'H' => H,
		'I' => I,
		'J' => J,
		'K' => K,
		'L' => L,
		'M' => M,
		'N' => N,
		'O' => O,
		'P' => P,
		'Q' => Q,
		'R' => R,
		'S' => S,
		'T' => T,
		'U' => U,
		'V' => V,
		'W' => W,
		'X' => X,
		'Y' => Y,
		'Z' => Z,
		// Numbers (top row)
		'0' => ZERO,
		'1' => ONE,
		'2' => TWO,
		'3' => THREE,
		'4' => FOUR,
		'5' => FIVE,
		'6' => SIX,
		'7' => SEVEN,
		'8' => EIGHT,
		'9' => NINE,
		// Symbols
		'`' => GRAVEACCENT,
		'-' => MINUS,
		'[' => LBRACKET,
		']' => RBRACKET,
		'\\' => BACKSLASH,
		';' => SEMICOLON,
		'\'' => QUOTE,
		',' => COMMA,
		'.' => PERIOD,
		'/' => SLASH,
		// Whitespace & basic controls
		' ' => SPACE,
		'\t' => TAB,
		'\n' => ENTER,
		'BACKSPACE' => BACKSPACE,
		'ESCAPE' => ESCAPE,
		// Function keys
		'F1' => F1,
		'F2' => F2,
		'F3' => F3,
		'F4' => F4,
		'F5' => F5,
		'F6' => F6,
		'F7' => F7,
		'F8' => F8,
		'F9' => F9,
		'F10' => F10,
		'F11' => F11,
		'F12' => F12,
		// Arrow keys
		'UP' => UP,
		'DOWN' => DOWN,
		'LEFT' => LEFT,
		'RIGHT' => RIGHT
	];
}
