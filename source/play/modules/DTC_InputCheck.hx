package play.modules;

class DTC_InputCheck
{
	public static function execute()
	{
		if (FlxG.keys.justReleased.ENTER && PlayState.instance.can_press_enter)
			PlayState.instance.nextDialogue();

		if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices != null)
			if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices.length > 0)
			{
				if (FlxG.keys.anyJustReleased(PlayState.instance.choices_keys))
				{
					var i = 0;
					for (key in PlayState.instance.choices_keys)
					{
						if (FlxG.keys.anyJustReleased([key]))
							ScriptsManager.callScript(PlayState.instance.choices_events[i], [], () ->
							{
								PlayState.instance.nextDialogue();
							});
						i++;
					}
				}
			}
	}
}
