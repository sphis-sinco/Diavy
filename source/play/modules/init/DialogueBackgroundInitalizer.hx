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

		final currentDialogue = PlayState.instance.dialogue[PlayState.instance.dialogue_progress];

		final imagePath = 'dialogue/backgrounds/' + PlayState.instance.dialogue[PlayState.instance.dialogue_progress].background;

		PlayState.instance.remove(dialogue_background);

		if (!FileSystem.exists(Assets.getImagePath(imagePath)))
			return;

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

		try
		{
			if (dialogue_background == null)
				return;

			if (currentDialogue.backgroundSettings != null)
			{
				if (currentDialogue.backgroundSettings.positionOffsets != null)
				{
					dialogue_background.x += currentDialogue.backgroundSettings.positionOffsets.x;
					dialogue_background.y += currentDialogue.backgroundSettings.positionOffsets.y;
				}
				if (currentDialogue.backgroundSettings.scaleOffsets != null)
				{
					dialogue_background.scale.x += currentDialogue.backgroundSettings.scaleOffsets.x;
					dialogue_background.scale.y += currentDialogue.backgroundSettings.scaleOffsets.y;
				}

				// the id is just for scripts
			}
		}
		catch (e)
		{
			trace(e);
		}

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.dialogueBackgroundInit, [dialogue_background]);
	}

	override function getValues():FlxSprite
	{
		return dialogue_background;
	}
}
