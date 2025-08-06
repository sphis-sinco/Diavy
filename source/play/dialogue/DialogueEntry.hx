package play.dialogue;

import play.dialogue.entry.*;

typedef DialogueEntry =
{
	var line:String;

	var ?script_event:ScriptEventEntry;
	var ?script_events:Array<ScriptEventEntry>;

	var ?character:String;
	var ?background:String;

	var ?characterSettings:DialogueSpriteSettings;
	var ?backgroundSettings:DialogueSpriteSettings;

	var ?choices:Array<DialogueChoice>;

	var ?wait:Float;

	var ?speed:Float;
}
