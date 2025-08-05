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

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.nextDialogue);
	}
}
