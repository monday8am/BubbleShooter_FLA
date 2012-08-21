package
{
	import com.monday8am.greenfoot.Greenfoot;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.system.Capabilities;
	
	import game.BubbleWorld;
	
	import net.hires.debug.Stats;
	
	
	[SWF(backgroundColor="#ffffff", frameRate="24", width="350", height="600")]
	public class BubbleShooter_FLA extends Sprite
	{
		
		private var bubble : BubbleWorld;
		
		public function BubbleShooter_FLA()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Greenfoot.instance.init( this );
			bubble = new BubbleWorld();
			addChild( bubble );
			
			// add stats
			if( Capabilities.isDebugger )
			{			
				var stats : Stats = new Stats();
				addChild( stats );
				stats.scaleX =
				stats.scaleY = 1;
				stats.y = 400;
				
			}			
			
		}
			
		
	}
}