package play.modules.dialogue;

class BeginDialogue
{
	public static function execute()
	{
		PlayState.instance.dialogue_box.alpha = 0;
		PlayState.instance.dialogue_text.alpha = 0;
		PlayState.instance.dialogue_progress = 0;

		if (Compiler.getDefine('STARTING_LINE') != null && Compiler.getDefine('STARTING_LINE') != '1')
			PlayState.instance.dialogue_progress = Std.parseInt(Compiler.getDefine('STARTING_LINE').split('=')[0]);

		BeginDialogueTween.execute();

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.beginDialogue);
	}
}
