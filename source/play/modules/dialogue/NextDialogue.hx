package play.modules.dialogue;

class NextDialogue
{
	public static function execute()
	{
		PlayState.instance.dialogue_progress++;

		PlayState.instance.dialogueEntryNullChecks();

		NextDialogueEndCheck.execute();

		PlayState.instance.beginDialogueTyping();

		PlayState.instance.initalizeDialogueBackground();
		PlayState.instance.initalizeDialogueCharacter();

		if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].script_event != null)
			ScriptsManager.callScript(PlayState.instance.dialogue[PlayState.instance.dialogue_progress].script_event);

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.nextDialogue);
	}
}
