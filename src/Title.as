package
{
import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxG;

public class Title extends FlxState {
	[Embed(source="../assets/images/background.png")] protected var img_Background:Class;

	private var m_background:FlxSprite = new FlxSprite(0, 0, img_Background);
	private var m_title:FlxText = new FlxText(0, 20, 320);
	private var m_xtostart:FlxText = new FlxText(0, 60, 320);
	private var m_instructions:FlxText = new FlxText(0, 100, 320);
	private var m_credits:FlxText = new FlxText(0, 0, 320);
	private var m_HUD:HUD = new HUD;

	public function Title():void
	{
		super();
		m_title.setFormat(null, 24, 0xffb91a1a, "center", 0xcc890808);
		m_xtostart.setFormat(null, 24, 0xff1a1ab9, "center", 0xcc090889);
		m_instructions.setFormat(null, 16, 0xffb9b91a, "center", 0xcc898909);
		m_credits.setFormat(null, 8, 0xffb9b9b9, "left", 0xcc404040);

		m_title.text = "INSANE INVADERS";
		m_xtostart.text = "'X' TO START";
		m_instructions.text = "'LEFT' - MOVE LEFT\n'RIGHT' - MOVE RIGHT\n'X' - FIRE\n'P' - PAUSE";
		m_credits.text =
		"Flixel 2.35 - flixel.org\n" +
		"Music by Kevin MacLeod - incompetech.com\n" +
		"Code by Grzegorz Gwozdz - gregoryprogrammer.com";
		m_credits.y = 240 - m_credits.height - 2;
		m_credits.x = 2;
	}

	override public function create():void
	{
		add(m_background);
		add(m_title);
		add(m_xtostart);
		add(m_instructions);
		add(m_credits);
		add(m_HUD);

		m_HUD.show_frame();
		m_HUD.show_version();

		Manager.level = 1;
		Manager.lives = 3;
	}

	override public function update():void
	{
		super.update();

		if (FlxG.keys.X)
			FlxG.state = Manager.state_wave;
	}
}
} // package
