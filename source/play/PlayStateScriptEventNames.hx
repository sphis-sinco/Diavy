package play;

class PlayStateScriptEventNames
{
	public static var list = {
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
		dialogueBackgroundInit: 'initalizeDialogueBackground',
		dialogueCharacterInit: 'initalizeDialogueCharacter',
		dialogueBoxInit: 'initalizeDialogueBox',
		dialogueTextInit: 'initalizeDialogueText',
		preferencesInit: 'initalizePreferences',
		deNullChecks: 'dialogueEntryNullChecks',
		nextDialogue: 'nextDialogue',
		beginDialogueTyping: 'beginDialogueTyping',
	};
}
