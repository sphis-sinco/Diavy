package play.modules.init;

class DialogueCharacterInitalizer extends Initalizer
{
	public var dialogue_character:FlxSprite;

	override public function new(dialogue_character:FlxSprite)
	{
		this.dialogue_character = dialogue_character;

		super();
	}

	override function initalize()
	{
		super.initalize();

		if (PlayState.instance == null)
			return;

		final imagePath = 'dialogue/characters/' + PlayState.instance.dialogue[PlayState.instance.dialogue_progress].character;

		PlayState.instance.remove(dialogue_character);

		if (!FileSystem.exists(Assets.getImagePath(imagePath)))
			return;

		if (dialogue_character != null)
		{
			if (dialogue_character.graphic == new FlxSprite().loadGraphic(Assets.getImagePath(imagePath)).graphic)
			{
				PlayState.instance.addObject(dialogue_character);
				return;
			}
		}

		try
		{
			dialogue_character = new FlxSprite(0, 0);
			dialogue_character.loadGraphic(Assets.getImagePath(imagePath));
			dialogue_character.screenCenter(XY);
			PlayState.instance.addObject(dialogue_character);
		}
		catch (e)
		{
			trace(e);
		}
	}

	override function getValues():FlxSprite
	{
		return dialogue_character;
	}
}
