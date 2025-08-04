package play.dialogue;

import play.dialogue.entry.*;

typedef DialogueEntry =
{
	var line:String;
	var ?character:String;
	var ?background:String;
	var ?choices:Array<DialogueChoice>;
}
