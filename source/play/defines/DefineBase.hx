package play.defines;

class DefineBase
{
	public var name:String = 'DefineBase';

	public function value():String
		return null;

	public function new(name:String)
	{
		this.name = name;
	}
}
