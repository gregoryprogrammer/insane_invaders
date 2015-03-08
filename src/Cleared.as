package
{
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

public class Cleared extends FlxState {
	[Embed(source="../assets/images/background.png")] protected var img_Background:Class;

	private var m_cooldown:Number = 1.0;
	private var m_background:FlxSprite = new FlxSprite(0, 0, img_Background);
	private var m_cleared:FlxText = new FlxText(0, 60, 320);
	private var m_extra:FlxText = new FlxText(0, 90, 320);
	private var m_HUD:HUD = new HUD;

	public function Cleared():void
	{
		super();

		m_cleared.setFormat(null, 24, 0xff1a1ab9, "center", 0xcc090889);
		m_extra.setFormat(null, 24, 0xffb9b91a, "center", 0xcc898909);
	}

	override public function create():void
	{
		add(m_background);
		add(m_cleared);
		add(m_HUD);

		m_HUD.show_frame();
		m_HUD.show_version();
		m_cooldown = 1.0;

		m_extra.text = "EXTRA LIFE";
		m_cleared.text = "WAVE " + Manager.level + " CLEARED";
		if (Manager.level > 1 && (Manager.level % 5 == 0)) {
			add(m_extra);
			Manager.lives += 1;
			FlxG.log("EXTRA LIFE");
		}
	}

	override public function update():void
	{
		super.update();
		if (m_cooldown > 0) {
			m_cooldown -= FlxG.elapsed;
		} else {
			Manager.level += 1;
			FlxG.state = Manager.state_wave;
		}
	}
}
} // package
