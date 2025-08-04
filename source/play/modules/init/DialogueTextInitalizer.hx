package play.modules.init;

import flixel.addons.text.FlxTypeText;
import flixel.util.FlxColor;

class DialogueTextInitalizer extends Initalizer
{
	public var dialogue_text:FlxTypeText;
	public var dialogue_box:FlxSprite;
	public var dialogue_proceed_icon:FlxSprite;

	override public function new(dialogue_box:FlxSprite, dialogue_proceed_icon:FlxSprite, dialogue_text:FlxTypeText)
	{
		this.dialogue_box = dialogue_box;
		this.dialogue_proceed_icon = dialogue_proceed_icon;
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

		dialogue_text.fieldWidth = dialogue_box.width - 10;
		dialogue_text.color = FlxColor.BLACK;
		dialogue_text.setPosition(dialogue_box.x + 5, dialogue_box.y + 5);

		dialogue_text.startCallback = () ->
		{
			if (PlayState.instance != null)
				PlayState.instance.dialogue_text_typing_complete = false;

			if (dialogue_proceed_icon != null)
				dialogue_proceed_icon.visible = false;
		};
		dialogue_text.completeCallback = () ->
		{
			if (PlayState.instance != null)
				PlayState.instance.dialogue_text_typing_complete = true;
			if (dialogue_proceed_icon != null)
				dialogue_proceed_icon.visible = true;
		};
	}

	override function getValues():FlxTypeText
	{
		return dialogue_text;
	}
}
