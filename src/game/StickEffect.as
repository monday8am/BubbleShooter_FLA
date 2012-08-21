package game
{
	import flash.display.MovieClip;
	
	public class StickEffect extends SmoothActor
	{
		
		
		public function StickEffect()
		{
			
		}
		
		override public function doIt( deltaTime : Number ):void
		{
			this.alpha -= deltaTime * 16.0;
			
			if( alpha <= 0)
			{
				getWorld().removeObject(this);
				return;
			}
			
			// set alpha
			
			//getImage().setTransparency((int)alpha);					
		}
	}
}