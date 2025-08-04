package play.modules.scripts;

class PlayStateScriptEvent
{
	var eventName:String = 'unimplemented_PSSE';
	var eventArgs:Array<Dynamic> = [];

	public function new(name:String = 'unimplemented_PSSE', ?args:Array<Dynamic>)
	{
		eventName = name;
		eventArgs = args ?? [];
	}

	public function getEventName():String
	{
		return eventName;
	}

	public function getEventArgs():Array<Dynamic>
	{
		return eventArgs;
	}
}
