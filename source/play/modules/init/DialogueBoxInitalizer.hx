package play.modules.init;

import play.dialogue.DialoguePositionEnum;

class DialogueBoxInitalizer extends Initalizer
{
	public var dialogue_box:FlxSprite;
	public var dialoguePosition:DialoguePositionEnum;

	override public function new(dialogue_box:FlxSprite, dialoguePosition:DialoguePositionEnum)
	{
		this.dialogue_box = dialogue_box;
		this.dialoguePosition = dialoguePosition;

		super();
	}

	override function initalize()
	{
		super.initalize();

		if (dialogue_box == null)
		{
			dialogue_box = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * .75), Std.int(FlxG.height * .25));
			dialogue_box.screenCenter(X);
			if (PlayState.instance != null)
				PlayState.instance.addObject(dialogue_box);
		}

		dialogue_box.y = FlxG.height - dialogue_box.height - 32;
		if (dialoguePosition == TOP)
			dialogue_box.y = dialogue_box.height * .25;
	}

	override function getValues():FlxSprite
	{
		return dialogue_box;
	}
}
