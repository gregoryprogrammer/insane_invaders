package
{
import org.flixel.FlxState;

public class Manager {
	static public var state_title:FlxState = new Title as FlxState;
	static public var state_wave:FlxState = new Wave as FlxState;
	static public var state_playstate:FlxState = new Playstate as FlxState;
	static public var state_cleared:FlxState = new Cleared as FlxState;
	static public var state_gameover:FlxState = new Gameover as FlxState;

	static public var level:int = 99;
	static public var lives:int = 3;
}
} // package
