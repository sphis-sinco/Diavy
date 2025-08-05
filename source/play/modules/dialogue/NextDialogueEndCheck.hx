package play.modules.dialogue;

class NextDialogueEndCheck
{
	public static function execute()
	{
		if (PlayState.instance.dialogue_progress >= PlayState.instance.dialogue.length)
		{
			PlayState.instance.dialogue_progress--;
			if (PlayState.instance.dialogue_end_callback != null) PlayState.instance.dialogue_end_callback();
			else
			{
				trace('End');
				Sys.exit(127);
			}
		}
	}
}
