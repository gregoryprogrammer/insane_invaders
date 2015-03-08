package
{
import flash.ui.Mouse;
import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxEmitter;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;
import org.flixel.FlxG;
import org.flixel.FlxU;

public class Playstate extends FlxState {
	[Embed(source="../assets/images/background.png")] protected var img_Background:Class;
	[Embed(source="../assets/images/turret.png")] protected var img_Turret:Class;
	[Embed(source="../assets/images/turret_bullet.png")] protected var img_TurretBullet:Class;

	[Embed(source="../assets/sounds/turret.mp3")] protected var snd_Turret:Class;
	[Embed(source="../assets/sounds/hit.mp3")] protected var snd_Hit:Class;
	[Embed(source="../assets/sounds/enemy.mp3")] protected var snd_Enemy:Class;

	private var m_background:FlxSprite = new FlxSprite(0, 0, img_Background);
	private var m_turret:FlxSprite = new FlxSprite(160 -8, 224);
	private var m_bullets:FlxGroup = new FlxGroup;
	private var m_invaders:Invaders = new Invaders;
	private var m_HUD:HUD = new HUD;

	private var m_fireCooldown:Number = 0.0;

	private var m_turretParticles:FlxEmitter = new FlxEmitter;
	private var m_invadersCrap:Array = new Array;
	private var m_lastCrapEmitter:int = 0;

	private var m_inDeath:Boolean = false;
	private var m_deathCooldown:Number = 0.0;

	public function Playstate():void
	{
		super();

		m_turret.loadGraphic(img_Turret);
		m_turret.maxVelocity.x = 300;
		m_turret.drag.x = 500;

		m_turretParticles.y = 220;
		m_turretParticles.setXSpeed(-100, 100);
		m_turretParticles.setYSpeed(-150, 0);
	}

	override public function create():void
	{
		add(m_background);
		add(m_turret);
		add(m_bullets);
		add(m_invaders);
		add(m_turretParticles)
		add(m_HUD);

		var i:int, j:int;
		m_fireCooldown = 0.0;
		m_deathCooldown = 0.0;

		m_HUD.show_frame();
		m_HUD.show_game_info();
		m_HUD.show_version();

		m_invaders.create();

		for (i = 0; i<m_invadersCrap.length; ++i)
			add(m_invadersCrap[i]);

		for (i = 0; i < 16; ++i) {
			var particle:FlxSprite = new FlxSprite;
			particle.createGraphic(4, 8, 0xdd6464af);
			m_turretParticles.add(particle);
		}

		m_invadersCrap.length = 0;
		for (j = 0; j < 12; ++j) {
			var invaderCrap:FlxEmitter = new FlxEmitter;
			invaderCrap.y = 220;
			invaderCrap.setXSpeed(-100, 100);
			invaderCrap.setYSpeed(-150, 0);
			invaderCrap.setRotation(0, 0);
			for (i = 0; i < 4; ++i) {
				var crap:FlxSprite = new FlxSprite;
				crap.createGraphic(4, 4, 0xdd4949ab);
				invaderCrap.add(crap);
			}
			m_invadersCrap.push(invaderCrap);
			add(invaderCrap);
		}

		for (i = 0; i < 8; ++i) {
			var oneBullet:FlxSprite = new FlxSprite(0, 0);
			oneBullet.loadGraphic(img_TurretBullet);
			oneBullet.visible = false;
			m_bullets.add(oneBullet);
		}
	}

	override public function update():void
	{
		super.update();
		var i:int, j:int;

		// turret controls
		if (FlxG.keys.LEFT && m_deathCooldown < 1.5) {
			m_turret.acceleration.x = -1000;
		} else if (FlxG.keys.RIGHT && m_deathCooldown < 1.5) {
			m_turret.acceleration.x = 1000;
		} else {
			m_turret.acceleration.x = 0;
			m_turret.velocity.x *= 0.9;
		}

		// turret boundings
		if (m_turret.x < 4) {
			m_turret.x = 4;
			m_turret.velocity.x = 0;
		} else if (m_turret.x > 320 - 4 - 16) {
			m_turret.x = 320 - 4 - 16;
			m_turret.velocity.x = 0;
		}

		// bullet check
		for (i = 0; i < m_bullets.members.length; ++i) {
			if (m_bullets.members[i].y < 0) {
				m_bullets.members[i].velocity.y = 0;
				m_bullets.members[i].visible = false;
			}
		}

		// fire
		if (FlxG.keys.X && m_fireCooldown <= 0 && m_deathCooldown < 1.5) {
			for (i = 0; i < m_bullets.members.length; ++i) {
				if (m_bullets.members[i].visible != false)
					continue;
				m_bullets.members[i].x = m_turret.x + 6;
				m_bullets.members[i].y = 224;
				m_bullets.members[i].velocity.y = -300;
				m_bullets.members[i].visible = true;
				m_fireCooldown = 0.15;
				FlxG.play(snd_Turret);
				break;
			}
		}

		if (m_fireCooldown > 0)
			m_fireCooldown -= FlxG.elapsed;

		if (m_deathCooldown > 0)
			m_deathCooldown -= FlxG.elapsed;

		if (m_invaders.destroyed()) {
			if(Manager.level == 100)
				FlxG.state = Manager.state_gameover;
			else
				FlxG.state = Manager.state_cleared;
		}

		if (m_inDeath && m_deathCooldown < 1.5) {

			if (Manager.lives == 0)
				FlxG.state = Manager.state_gameover;

			if (int(m_deathCooldown*10) % 2)
				m_turret.visible = false;
			else
				m_turret.visible = true;
		}

		if (m_inDeath && m_deathCooldown <= 0) {
			m_turret.visible = true;
			m_inDeath = false;
		}

		FlxU.overlap(m_bullets, m_invaders, on_bullet_hit);
		if (!m_inDeath)
			FlxU.overlap(m_turret, m_invaders, on_player_hit);
	}

	private function on_bullet_hit(bullet:FlxSprite, invader:FlxSprite):void
	{
		bullet.visible = false;
		bullet.velocity.y = 0;
		bullet.x = -100;
		bullet.y = -100;

		if (invader is Invader) {
			emit_crap(invader.x, invader.y);
			FlxG.play(snd_Enemy);
			invader.kill();
		} else {
			invader.velocity.y = 0;
			invader.visible = false;
			invader.x = 420;
			invader.y = -100;
		}
	}

	private function on_player_hit(AA:FlxObject, BB:FlxObject):void
	{
		m_turretParticles.x = m_turret.x + 12;
		m_turretParticles.y = m_turret.y + 8;
		m_turretParticles.start();
		m_turret.visible = false;
		m_inDeath = true;
		m_deathCooldown = 3;
		Manager.lives -= 1;
		m_HUD.update_info();
		FlxG.play(snd_Hit);
	}

	private function emit_crap(x:int, y:int):void
	{
		m_invadersCrap[m_lastCrapEmitter].x = x;
		m_invadersCrap[m_lastCrapEmitter].y = y;
		m_invadersCrap[m_lastCrapEmitter].start();
		m_lastCrapEmitter += 1;
		m_lastCrapEmitter %= m_invadersCrap.length;
	}
}
} // package
