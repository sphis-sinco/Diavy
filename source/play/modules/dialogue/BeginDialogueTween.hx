package play.modules.dialogue;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class BeginDialogueTween
{
	public static function execute()
	{
		FlxTween.tween(PlayState.instance.dialogue_box, {alpha: 1}, 1,
			{
				ease: FlxEase.sineIn,
				onStart: tween -> ScriptsManager.callScript(PlayState.instance.scriptEventNames.dialogueBoxInit_tweenStart, [PlayState.instance.dialogue_box]),
				onUpdate: tween -> ScriptsManager.callScript(PlayState.instance.scriptEventNames.dialogueBoxInit_tweenUpdate,
					[PlayState.instance.dialogue_box]),
				onComplete: tween -> ScriptsManager.callScript(PlayState.instance.scriptEventNames.dialogueBoxInit_tweenComplete,
					[PlayState.instance.dialogue_box])
			});
		FlxTween.tween(PlayState.instance.dialogue_text, {alpha: 1}, 1,
			{
				ease: FlxEase.sineIn,
				onStart: tween -> ScriptsManager.callScript(PlayState.instance.scriptEventNames.dialogueTextInit_tweenStart,
					[PlayState.instance.dialogue_text]),
				onUpdate: tween -> ScriptsManager.callScript(PlayState.instance.scriptEventNames.dialogueTextInit_tweenUpdate,
					[PlayState.instance.dialogue_text]),
				onComplete: tween -> {
					PlayState.instance.beginDialogueTyping();
					ScriptsManager.callScript(PlayState.instance.scriptEventNames.dialogueTextInit_tweenComplete, [PlayState.instance.dialogue_text]);
				}
			});
	}
}
