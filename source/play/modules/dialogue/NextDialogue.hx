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
		{
			if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].script_event.name == 'startMusic')
				PlayState.startMusic(PlayState.instance.dialogue[PlayState.instance.dialogue_progress].script_event.args[0]);
			ScriptsManager.callScript(PlayState.instance.dialogue[PlayState.instance.dialogue_progress].script_event.name,
				PlayState.instance.dialogue[PlayState.instance.dialogue_progress].script_event.args ?? []);
		}

		if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].script_events != null)
			for (script in PlayState.instance.dialogue[PlayState.instance.dialogue_progress].script_events)
			{
				if (script.name == 'startMusic')
					PlayState.startMusic(script.args[0]);
				ScriptsManager.callScript(script.name, script.args ?? []);
			}

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.nextDialogue);
	}
}
