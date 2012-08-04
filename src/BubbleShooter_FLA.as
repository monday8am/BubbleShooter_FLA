package
{
	import com.monday8am.greenfoot.Greenfoot;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.system.Capabilities;
	
	import game.BubbleWorld;
	
	
	[SWF(backgroundColor="#ffffff", frameRate="24", width="350", height="600")]
	public class BubbleShooter_FLA extends Sprite
	{
		
		private var bubble : BubbleWorld;
		
		public function BubbleShooter_FLA()
		{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// init app..

			if( Capabilities.isDebugger )
			{

			}				
			
			
			Greenfoot.instance.init( this );
			
			bubble = new BubbleWorld();

			addChild( bubble );
			
		}
			
		
	}
}