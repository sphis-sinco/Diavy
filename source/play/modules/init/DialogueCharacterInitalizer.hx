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

		final currentDialogue = PlayState.instance.dialogue[PlayState.instance.dialogue_progress];

		final imagePath = 'dialogue/characters/' + currentDialogue.character;

		if (dialogue_character != null)
			PlayState.instance.remove(dialogue_character);

		if (!FileSystem.exists(Assets.getImagePath(imagePath)))
			return;

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

		try
		{
			if (dialogue_character == null)
				return;

			if (currentDialogue.characterSettings != null)
			{
				if (currentDialogue.characterSettings.positionOffsets != null)
				{
					dialogue_character.x += currentDialogue.characterSettings.positionOffsets.x;
					dialogue_character.y += currentDialogue.characterSettings.positionOffsets.y;
				}
				if (currentDialogue.characterSettings.scaleOffsets != null)
				{
					dialogue_character.scale.x += currentDialogue.characterSettings.scaleOffsets.x;
					dialogue_character.scale.y += currentDialogue.characterSettings.scaleOffsets.y;
				}
				if (currentDialogue.characterSettings.flipped != null)
				{
					dialogue_character.flipX = currentDialogue.characterSettings.flipped.x;
					dialogue_character.flipY = currentDialogue.characterSettings.flipped.y;
				}

				// the id is just for scripts
			}
		}
		catch (e)
		{
			trace(e);
		}

		ScriptsManager.callScript(PlayState.instance.scriptEventNames.dialogueCharacterInit, [dialogue_character]);
	}

	override function getValues():FlxSprite
	{
		return dialogue_character;
	}
}
