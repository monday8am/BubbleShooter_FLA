package game
{
	
	import com.monday8am.greenfoot.Actor;
	
	import flash.display.MovieClip;
	
	
	public class SmoothActor extends Actor
	{
		
		private   var oldTime : uint  = 0;
		protected var ticks   : uint  = 0;		

		protected var deltaTime : Number;
		
		
		public function SmoothActor()
		{
			super();
		}
		
		
		override public function act() : void 
		{
			var newTime : uint = new Date().time();
			
			// We'll handle time in units of 1/100 seconds.
			deltaTime = (newTime - oldTime) / 10000000.0;
			
			// If this is the first tick, assume some reasonable amount of time elapsed. (1/100 s)
			if( ticks == 0)
			{
				deltaTime = 1;
			}
			
			// Because of OS issues and timer glitches, we could get way too big values here if the game
			// freezes for a short while. So cap the deltaTime to some good value (1/25 s).
			if(deltaTime >= 4)
			{
				deltaTime = 4;
			}
			
			// Save the old time stamp.
			oldTime = newTime;
			
			// Call the subclass.
			//act( deltaTime );
			
			// Increment tick count.
			ticks++;
		}    
	
	}
}





