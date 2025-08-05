package play.modules.init;

import flixel.addons.text.FlxTypeText;
import flixel.util.FlxTimer;
import play.modules.dialogue.BeginDialogueTyping;

class DialogueTextInitalizer extends Initalizer
{
	public var dialogue_text:FlxTypeText;

	override public function new(dialogue_text:FlxTypeText)
	{
		this.dialogue_text = dialogue_text;
		super();
	}

	override function initalize()
	{
		super.initalize();

		if (dialogue_text == null)
		{
			dialogue_text = new FlxTypeText(0, 0, 0, '', 16);
			if (PlayState.instance != null)
				PlayState.instance.addObject(dialogue_text);
		}

		dialogue_text.showCursor = true;
		dialogue_text.useDefaultSound = true;

		dialogue_text.fieldWidth = PlayState.instance.dialogue_box.width - 10;
		dialogue_text.color = FlxColor.BLACK;
		dialogue_text.setPosition(PlayState.instance.dialogue_box.x + 5, PlayState.instance.dialogue_box.y + 5);

		dialogue_text.startCallback = () ->
		{
			if (PlayState.instance != null)
				PlayState.instance.dialogue_text_typing_complete = false;

			if (PlayState.instance.dialogue_proceed_icon != null)
				PlayState.instance.dialogue_proceed_icon.visible = false;
		};
		dialogue_text.completeCallback = () ->
		{
			if (PlayState.instance != null)
			{
				PlayState.instance.dialogue_text_typing_complete = true;
				PlayState.instance.can_press_enter = true;

				if (PlayState.instance.dialogue_proceed_icon != null)
					PlayState.instance.dialogue_proceed_icon.visible = true;

				try
				{
					if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices != null)
					{
						if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].choices.length > 0)
							PlayState.instance.can_press_enter = false;
					}

					if (PlayState.instance.dialogue[PlayState.instance.dialogue_progress].wait != null)
					{
						if (PlayState.instance.dialogue_proceed_icon != null)
							PlayState.instance.dialogue_proceed_icon.visible = false;
						PlayState.instance.can_press_enter = false;
						PlayState.instance.dialogue_text_typing_complete = false;
						FlxTimer.wait(PlayState.instance.dialogue[PlayState.instance.dialogue_progress].wait, () ->
						{
							PlayState.instance.dialogue_text_typing_complete = true;
							PlayState.instance.can_press_enter = true;
							if (PlayState.instance.dialogue_proceed_icon != null)
								PlayState.instance.dialogue_proceed_icon.visible = true;
							PlayState.instance.choice_text.start(BeginDialogueTyping.controlsLine);
						});
					}

					if (PlayState.instance.can_press_enter)
						PlayState.instance.choice_text.start(BeginDialogueTyping.controlsLine);
				}
				catch (e)
				{
					trace(e);
				}
			}
		};

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.dialogueTextInit, [dialogue_text]);
	}

	override function getValues():FlxTypeText
	{
		return dialogue_text;
	}
}
