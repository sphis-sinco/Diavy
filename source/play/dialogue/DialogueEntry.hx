package play.dialogue;

import play.dialogue.entry.*;

typedef DialogueEntry =
{
	var line:String;
	var ?choices:Array<DialogueChoice>;
}
