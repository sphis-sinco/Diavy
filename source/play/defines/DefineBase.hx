package play.defines;

class DefineBase
{
	public var name:String = 'DefineBase';

	public function value():String
		return raw_value().split('=')[0];

	public function valid():Bool
	{
		return value() != null && raw_value() != '1';
	}

	public function raw_value():String
	{
		return null;
	}

	public function new(name:String)
	{
		this.name = name;
	}
}
