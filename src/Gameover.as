package
{
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

public class Gameover extends FlxState {
	[Embed(source="../assets/images/background.png")] protected var img_Background:Class;

	private var m_cooldown:Number = 1.0;

	private var m_background:FlxSprite = new FlxSprite(0, 0, img_Background);
	private var m_gameover:FlxText = new FlxText(0, 30, 320);
	private var m_restart:FlxText = new FlxText(0, 120, 320);
	private	var m_reached:FlxText = new FlxText(0, 60, 320);
	private var m_HUD:HUD = new HUD;

	public function Gameover():void
	{
		super();
		m_gameover.setFormat(null, 24, 0xff1a1ab9, "center", 0xcc090889);
		m_restart.setFormat(null, 24, 0xff1ab91a, "center", 0xcc088908);
		m_reached.setFormat(null, 24, 0xff1a1ab9, "center", 0xcc090889);
	}

	override public function create():void
	{
		add(m_background);
		add(m_gameover);
		add(m_restart);
		add(m_HUD);

		m_HUD.show_frame();
		m_HUD.show_version();
		m_restart.text = "'R' TO RESTART";

		m_cooldown = 1.0;

		if (Manager.level == 100) {
			m_gameover.text = "YOU SAVED THE EARTH";
		} else {
			m_gameover.text = "GAME OVER";
			m_reached.text = "WAVE " + Manager.level + " REACHED";
			add(m_reached);
		}
	}

	override public function update():void
	{
		super.update();

		if (FlxG.keys.R)
			FlxG.state = new Title;
	}
}
} // package
