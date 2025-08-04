package play.modules.init;

class DialogueBackgroundInitalizer extends Initalizer
{
	public var dialogue_background:FlxSprite;

	override public function new(dialogue_background:FlxSprite)
	{
		this.dialogue_background = dialogue_background;

		super();
	}

	override function initalize()
	{
		super.initalize();

		if (PlayState.instance == null)
			return;

		final imagePath = 'dialogue/backgrounds/' + PlayState.instance.dialogue[PlayState.instance.dialogue_progress].background;

		PlayState.instance.remove(dialogue_background);

		if (!FileSystem.exists(Assets.getImagePath(imagePath)))
			return;

		if (dialogue_background != null)
		{
			if (dialogue_background.graphic == new FlxSprite().loadGraphic(Assets.getImagePath(imagePath)).graphic)
			{
				PlayState.instance.addObject(dialogue_background);
				return;
			}
		}

		try
		{
			dialogue_background = new FlxSprite(0, 0);
			dialogue_background.loadGraphic(Assets.getImagePath(imagePath));
			dialogue_background.screenCenter(XY);
			PlayState.instance.addObject(dialogue_background);
		}
		catch (e)
		{
			trace(e);
		}
	}

	override function getValues():FlxSprite
	{
		return dialogue_background;
	}
}
