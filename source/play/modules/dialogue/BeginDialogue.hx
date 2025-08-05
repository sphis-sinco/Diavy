package play.modules.dialogue;

class BeginDialogue
{
	public static function execute()
	{
		PlayState.instance.dialogue_box.alpha = 0;
		PlayState.instance.dialogue_text.alpha = 0;
		PlayState.instance.dialogue_progress = 0;

		BeginDialogueTween.execute();

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.beginDialogue);
	}
}
