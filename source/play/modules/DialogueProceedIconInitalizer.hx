package play.modules;

class DialogueProceedIconInitalizer extends Initalizer
{
	public var dialogue_proceed_icon:FlxSprite;
	public var dialogue_box:FlxSprite;

	override public function new(dialogue_box:FlxSprite, dialogue_proceed_icon:FlxSprite)
	{
		this.dialogue_box = dialogue_box;
		this.dialogue_proceed_icon = dialogue_proceed_icon;
	}

	override function initalize()
	{
		super.initalize();

		if (dialogue_proceed_icon == null)
		{
			dialogue_proceed_icon = new FlxSprite(0, 0);
			dialogue_proceed_icon.loadGraphic(Assets.getImagePath('dialogue/proceed'));
			if (PlayState.instance != null)
				PlayState.instance.addObject(dialogue_proceed_icon);
		}

		dialogue_proceed_icon.setPosition((dialogue_box.x + dialogue_box.width - dialogue_proceed_icon.width),
			(dialogue_box.y + dialogue_box.height - dialogue_proceed_icon.height));
		dialogue_proceed_icon.visible = false;
	}

	override function getValues():FlxSprite
	{
		return dialogue_proceed_icon;
	}
}
