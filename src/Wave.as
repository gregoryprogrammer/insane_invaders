package
{
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

public class Wave extends FlxState {
	[Embed(source="../assets/images/background.png")] protected var img_Background:Class;

	private var m_cooldown:Number = 1.0;

	private var m_background:FlxSprite= new FlxSprite(0, 0, img_Background);
	private var m_wave:FlxText = new FlxText(0, 60, 320);
	private var m_go:FlxText = new FlxText(0, 120, 320);
	private var m_HUD:HUD = new HUD;

	public function Wave():void
	{
		super();

		m_wave.setFormat(null, 32, 0xffb91a1a, "center", 0xcc890808);
		m_go.setFormat(null, 24, 0xff1ab91a, "center", 0xcc088908);
	}

	override public function create():void
	{
		add(m_background);
		add(m_go);
		add(m_wave);
		add(m_HUD);

		m_HUD.show_frame();
		m_HUD.show_version();

		m_go.text = "GO!";
		m_go.visible = false;
		m_cooldown = 1.0;
		m_wave.text = "WAVE " + Manager.level;
	}

	override public function update():void
	{
		super.update();

		m_cooldown -= FlxG.elapsed;

		if (m_cooldown < 0)
			FlxG.state = Manager.state_playstate;
		else if (m_cooldown < 0.5)
			m_go.visible = true;
	}
}
} // package
