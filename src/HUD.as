package
{
import org.flixel.FlxGroup;
import org.flixel.FlxText;
import org.flixel.FlxSprite;

public class HUD extends FlxGroup {

	private var m_top_panel_back:FlxSprite = new FlxSprite(0, 0);
	private var m_top:FlxSprite = new FlxSprite(0, 0);
	private var m_left:FlxSprite = new FlxSprite(0, 0);
	private var m_right:FlxSprite = new FlxSprite(320 - 4, 0);
	private var m_bottom:FlxSprite = new FlxSprite(0, 240 - 4);

	private var m_version:FlxText = new FlxText(0, 0, 320);
	private var m_text_level:FlxText = new FlxText(0, 0, 320);
	private var m_text_lives:FlxText = new FlxText(0, 0, 320);

	public function HUD():void
	{
		m_top_panel_back.createGraphic(320, 24, 0xaa000000);
		m_top.createGraphic(320, 4, 0xaa000000);
		m_left.createGraphic(4, 240, 0xaa000000);
		m_right.createGraphic(4, 240, 0xaa000000);
		m_bottom.createGraphic(320, 4, 0xaa000000);

		m_text_lives.setFormat(null, 16, 0xffb9b91a, "right", 0xcc898909);
		m_text_level.setFormat(null, 16, 0xffb9b91a, "left", 0xcc898909);
		m_version.setFormat(null, 8, 0xffb9b9b9, "right", 0xcc404040);

		m_version.text = InsaneInvaders.version;
		m_version.x = 320 - m_version.width - 2;
		m_version.y = 240 - m_version.height - 2;
	}

	public function show_version():void
	{
		add(m_version);
	}

	public function show_frame():void
	{
		add(m_top);
		add(m_left);
		add(m_right);
		add(m_bottom);
	}

	public function show_game_info():void
	{
		add(m_top_panel_back);
		add(m_text_level);
		add(m_text_lives);
		update_info();
	}

	public function update_info():void
	{
		m_text_level.text = "WAVE: " + Manager.level;
		m_text_lives.text = "LIVES: " + Manager.lives;
	}
}
} // package
