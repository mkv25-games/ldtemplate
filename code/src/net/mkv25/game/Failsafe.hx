package net.mkv25.game;

class Failsafe
{
	private static var triggered:Bool = false;
	
	public static function trigger():Void
	{
		if (Failsafe.triggered)
		{
			throw "The glass has already been broken.";
		}
		
		Failsafe.triggered = true;
	}
}