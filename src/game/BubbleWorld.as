package game
{

	import com.monday8am.greenfoot.Greenfoot;
	import com.monday8am.greenfoot.World;
	
	import flash.display.MovieClip;
	
	
	public class BubbleWorld extends World
	{
		
		private var maps : Array =
			
			   ["7   7   7   7   7   7   7   7" +
				"  -   -   -   -   -   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -",
				
				"3   3   4   3   3   4   3   3" +
				"  -   -   3   4   3   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -",
				
				"6   6   4   4   2   2   3   3" +
				"  6   6   4   4   2   2   3" +
				"2   2   3   3   6   6   4   4" +
				"  2   3   3   6   6   4   4" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -" +
				"-   -   -   -   -   -   -   -" +
				"  -   -   -   -   -   -   -",
				
				"-   2   -   1   -   1   -   2"+
				"  1   2   -   2   1   -   1"+
				"1   -   1   -   2   -   2   -"+
				"  2   1   -   1   2   -   2"+
				"-   2   -   2   -   2   -   2"+
				"  1   2   -   2   1   -   1"+
				"1   -   1   -   2   -   1   -"+
				"  2   2   -   1   1   -   2"+
				"-   2   -   1   -   1   -   1"+
				"  -   -   -   -   -   -   -",
				
				"-   -   1   -   -   1   -   -"+
				"  -   2   4   -   2   4   -"+
				"-   2   3   6   5   3   2   -"+
				"  -   6   5   -   6   5   -"+
				"-   -   -   7   7   -   -   -"+
				"  -   -   -   7   -   -   -"+
				"1   -   -   7   7   -   -   3"+
				"  2   -   -   7   -   -   2"+
				"-   3   4   5   6   4   1   -"+
				"  -   -   -   -   -   -   -"
				
			];
		
		
		private var map    : Map;
		private var cannon : Cannon;
		private var sb 	   : ScoreBoard;
		
		private var level : int = 0;
		private var flag  : Boolean = true;
		private var levelNum : int = 5;	
		
		
		public function BubbleWorld()
		{
			super( Map.MAX_WIDTH * Map.COLUMN_WIDTH, Map.MAX_HEIGHT * Map.ROW_HEIGHT, 1, false ); 
			
			// Max speed. We use time-based animation so this is purely for smoothness,
			// because Greenfoot is plain stupid. I can't find a way to get 60 Hz so this is
			// what we have to do. Note: Exporting the game seems to cap this to some value < 100. :(
			Greenfoot.setSpeed(100);
			
			// Load the map.
			map = new Map( this, maps[0] );
			
			// Update the allowed ball types. (i.e. we don't want to spawn a
			// certain color of balls if the map doesn't contain them!)
			map.updateAllowedBallTypes();
			
			
			// Create the cannon.	
			cannon = new Cannon();
			addObject( cannon, getWidth()/2, getHeight());
			
		}
		
		
		public function getMap() : Map
		{
			return map;
		}
		
		
		public function act() : void
		{
			// Update map stuff.
			map.update();
			
			// Do something if the player cleared the map.
			if (map.hasWon()) 
			{
				if ( numberOfObjects() < 4) 
				{
					removeObject( sb );
					flag = true;
					
					level++;
					
					if ( level < levelNum) 
					{
						map = new Map( this, maps[level] );
						map.updateAllowedBallTypes();
						cannon.prepareBall();
					} 
					else
						Greenfoot.stop();
					
				} 
				else if (flag) 
				{
					sb = new ScoreBoard( "Map " + (level + 1) + "  Clear!" );
					addObject( sb, getWidth() / 2, getHeight() / 2);
					flag = false;
					
					// Play sound when the map is cleared.
					Greenfoot.playSound("cleared.wav");
				}
			}
		}
		
	}
}