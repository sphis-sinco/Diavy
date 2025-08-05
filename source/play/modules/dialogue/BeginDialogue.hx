package play.modules.dialogue;

import play.defines.*;

class BeginDialogue
{
	public static function execute()
	{
		PlayState.instance.dialogue_box.alpha = 0;
		PlayState.instance.dialogue_text.alpha = 0;
		PlayState.instance.dialogue_progress = 0;

		if (DefineManager.STARTING_LINE.valid())
			PlayState.instance.dialogue_progress = Std.parseInt(DefineManager.STARTING_LINE.value());

		BeginDialogueTween.execute();

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.beginDialogue);
	}
}
