package play.modules.dialogue;

class BeginDialogueTyping
{
	static var dialogueLine = '';
	public static var controlsLine = '';
	static var previousControlsLine = '';

	public static function execute()
	{
		PlayState.instance.dialogue_text.resetText('');
		try
		{
			PlayState.instance.choices_keys = [];
			PlayState.instance.choices_events = [];
			dialogueLine = PlayState.instance.dialogue[PlayState.instance.dialogue_progress].line;
			previousControlsLine = controlsLine;
			controlsLine = 'Controls:\n\nENTER - CONTINUE\n';

			if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices != null)
				if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices.length > 0)
				{
					controlsLine = 'Controls:\n\n';
					for (choice in PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices)
					{
						if (PlayState.instance.choices_keys_map.exists(choice.keyString.toUpperCase()))
						{
							PlayState.instance.choices_keys.push(PlayState.instance.choices_keys_map.get(choice.keyString.toUpperCase()));
							PlayState.instance.choices_events.push(choice.script_event);

							controlsLine += '${choice.keyString} - ${choice.name}\n';
						}
					}
				}

			controlsLine += 'BACKSPACE - Open Mod Menu\n';

			if (controlsLine != previousControlsLine)
				PlayState.instance.choice_text.resetText('');

			PlayState.instance.dialogue_text.start(dialogueLine, 0.05, false, false, []);
		}
		catch (e)
		{
			PlayState.instance.dialogue_text.start(e.message);
		}

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.beginDialogueTyping);
	}
}
