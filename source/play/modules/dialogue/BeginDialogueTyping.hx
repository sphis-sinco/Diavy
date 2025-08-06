package play.modules.dialogue;

class BeginDialogueTyping
{
	public static function execute()
	{
		PlayState.instance.dialogue_text.resetText('');
		try
		{
			PlayState.instance.choices_keys = [];
			PlayState.instance.choices_events = [];
			PlayState.instance.dialogueLine = PlayState.instance.dialogue[PlayState.instance.dialogue_progress].line;
			PlayState.instance.previousControlsLine = PlayState.instance.controlsLine;
			PlayState.instance.controlsLine = 'Controls:\n\nENTER - CONTINUE\n';

			if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices != null)
				if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices.length > 0)
				{
					PlayState.instance.controlsLine = 'Controls:\n\n';
					for (choice in PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices)
					{
						if (PlayState.instance.choices_keys_map.exists(choice.keyString.toUpperCase()))
						{
							PlayState.instance.choices_keys.push(PlayState.instance.choices_keys_map.get(choice.keyString.toUpperCase()));
							PlayState.instance.choices_events.push(choice.script_event);

							PlayState.instance.controlsLine += '${choice.keyString} - ${choice.name}\n';
						}
					}
				}

			PlayState.instance.controlsLine += 'BACKSPACE - Open Mod Menu\n';

			if (PlayState.instance.controlsLine != PlayState.instance.previousControlsLine)
				PlayState.instance.choice_text.resetText('');

			PlayState.instance.dialogue_text.start(PlayState.instance.dialogueLine,
				PlayState.instance.dialogue[PlayState.instance.dialogue_progress].text_speed ?? 0.05, false, false, []);
		}
		catch (e)
		{
			PlayState.instance.dialogue_text.start(e.message);
		}

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.beginDialogueTyping);
	}
}
