package;

import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.sound.FlxSound;
import play.*;
import play.dialogue.*;
import play.modules.*;
import play.modules.choices.*;
import play.modules.dialogue.*;
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

	public var scriptEventNames = PlayStateScriptEventNames.list;

	public var dialogue_end_callback:Void->Void;

	public var addObject = function(object:FlxBasic) {};

	public var dialogue_character:FlxSprite;
	public var dialogue_background:FlxSprite;

	public var addDialogue = function(dia:DialogueEntry) {};
	public var addDialogueArray = function(diaList:Array<DialogueEntry>) {};
	public var removeDialogueLine = function(dia:String) {};
	public var deleteAllDialogue = function() {};

	public var readDialogueJson = function(json:Array<DialogueEntry>) {};
	public var addDialogueJson = function(json:Array<DialogueEntry>) {};
	public var readDialogueJsonPath = function(path:String) {};
	public var addDialogueJsonPath = function(path:String) {};

	public var backLayer:FlxTypedGroup<FlxBasic> = new FlxTypedGroup<FlxBasic>();
	public var frontLayer:FlxTypedGroup<FlxBasic> = new FlxTypedGroup<FlxBasic>();

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

		addObject = function(object:FlxBasic) add(object);
		addDialogue = function(dia:DialogueEntry) this.dialogue.push(dia);
		deleteAllDialogue = function() dialogue = [];
		readDialogueJson = function(json:Array<DialogueEntry>) dialogue = json;
		readDialogueJsonPath = function(path:String) readDialogueJson(Assets.getJsonFile(path));
		addDialogueJsonPath = function(path:String) addDialogueJson(Assets.getJsonFile(path));

		addDialogueArray = function(diaList:Array<DialogueEntry>) for (dia in diaList)
			this.dialogue.push(dia);
		removeDialogueLine = function(targettedDia:String) for (dia in dialogue)
			if (dia.line == targettedDia)
				dialogue.remove(dia);
		addDialogueJson = function(json:Array<DialogueEntry>) for (dia in json)
			dialogue.push(dia);

		initalizePreferences();

		dialogue = [
			{line: 'Yo!'},
			{line: 'Coolswag Coolswag'},
			{line: 'You should probably add a mod or something.'}
		];
		ScriptsManager.callScript(scriptEventNames.setdialogue);
		dialogueEntryNullChecks();

		initalizeDialogueBackground();

		addObject(backLayer);

		initalizeDialogueCharacter();
		initalizeDialogueBox();
		dialogue_text = new DialogueTextInitalizer(dialogue_text).getValues();

		BeginDialogue.execute();

		initalizeChoicesText();

		addObject(frontLayer);

		var watermark:FlxText = new FlxText(0, 0, 0, 'Diavy || Release ${Main.gameRelease}', 16);
		frontLayer.add(watermark);
		watermark.x = 5;
		watermark.y = FlxG.height - watermark.height;

		ScriptsManager.callScript(scriptEventNames.create);
	}

	public var can_press_enter:Bool = false;
	public var choices_keys_map:Map<String, FlxKey> = ChoicesKeyMap.default_choices_key_map;
	public var choices_keys:Array<FlxKey> = [];
	public var choices_events:Array<String> = [];

	public static function startMusic(track:String)
	{
		FlxG.sound.music = new FlxSound().loadStream(Assets.getMusicPath(track), true);
		FlxG.sound.music.play();
	}

	public function initalizeChoicesText()
	{
		if (choice_text != null)
			remove(choice_text);

		choice_text.y = 10;
		choice_text.alignment = CENTER;
		choice_text.setBorderStyle(OUTLINE, FlxColor.BLACK, 2, 1);
		if (preferences.choiceTextSounds)
			choice_text.sounds = ChoiceTextSounds.getList();
		addObject(choice_text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		choice_text.screenCenter(X);

		if (FlxG.keys.justReleased.BACKSPACE)
		{
			PlayState.instance = null;
			FlxG.switchState(() -> new ModMenu());
		}

		if (dialogue_text_typing_complete)
			DTC_InputCheck.execute();

		ScriptsManager.callScript(scriptEventNames.update, [elapsed]);
	}

	public function initalizeDialogueBackground()
		dialogue_background = new DialogueBackgroundInitalizer(dialogue_background).getValues();

	public function initalizeDialogueCharacter()
		dialogue_character = new DialogueCharacterInitalizer(dialogue_character).getValues();

	public function initalizeDialogueBox()
	{
		dialogue_box = new DialogueBoxInitalizer(dialogue_box, preferences.dialoguePosition).getValues();
		dialogue_proceed_icon = new DialogueProceedIconInitalizer(dialogue_box, dialogue_proceed_icon).getValues();

		ScriptsManager.callScript(scriptEventNames.dialogueBoxInit, [dialogue_box]);
	}

	public function initalizePreferences()
	{
		preferences = {
			dialoguePosition: null,

			choiceTextSounds: null,

			defaultCharacter: '',
			defaultCharacterSettings: {},

			defaultBackground: '',
			defaultBackgroundSettings: {},
		};

		preferences.dialoguePosition ??= BOTTOM;
		preferences.choiceTextSounds ??= false;

		ScriptsManager.callScript(scriptEventNames.preferencesInit, [preferences]);
	}

	public function dialogueEntryNullChecks()
	{
		for (dialogueEntry in dialogue)
		{
			dialogueEntry.line ??= 'Null Entry';
			dialogueEntry.choices ??= [];
			dialogueEntry.characterSettings ??= preferences.defaultCharacterSettings;
			dialogueEntry.character ??= preferences.defaultCharacter;
			dialogueEntry.backgroundSettings ??= preferences.defaultBackgroundSettings;
			dialogueEntry.background ??= preferences.defaultBackground;
		}

		ScriptsManager.callScript(scriptEventNames.deNullChecks);
	}

	public var dialogueLine = '';
	public var controlsLine = '';
	public var previousControlsLine = '.';

	public function nextDialogue()
		NextDialogue.execute();

	public function beginDialogueTyping()
		BeginDialogueTyping.execute();
}
