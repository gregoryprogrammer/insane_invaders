package
{
import org.flixel.FlxGame;
import flash.ui.Mouse;

[SWF(width="640", height="480", backgroundColor="#000000", frameRate=60)]

public class InsaneInvaders extends FlxGame {

	static public var version:String = "1.2.0";

	public function InsaneInvaders():void
	{
		super(320, 240, Intro, 2);
	}
}
} // package
