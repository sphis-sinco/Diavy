package play;

import play.dialogue.DialoguePositionEnum;
import play.dialogue.entry.DialogueSpriteSettings;

typedef PlayStatePreferences =
{
	var dialoguePosition:DialoguePositionEnum;

	var ?choiceTextSounds:Bool;

	var ?defaultCharacter:String;
	var ?defaultBackground:String;
	var ?defaultCharacterSettings:DialogueSpriteSettings;
	var ?defaultBackgroundSettings:DialogueSpriteSettings;
}
