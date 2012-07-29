package game
{
	
	import game.Cell;
	import game.Position;
	
	public class Map
	{
		
		public static const MAX_WIDTH  : 	int = 8;      // maximum width of map in cells
		public static const MAX_HEIGHT :	int = 13;     // maximum height of map in cells
		public static const COLUMN_WIDTH :	int = 32;     // spacing between balls horizontally (pixels)
		public static const ROW_HEIGHT 	 :  int = 28;     // spacing between rows of balls (pixels)
		
		//private Cell[] cells = new Cell[MAX_WIDTH * MAX_HEIGHT]; // the map itself
		private var cells 			 : Array = new Array(); 			// the map itself
		private var allowedBallTypes : Array = new Array(); // array of currently allowed ball types
		private var won 			 : Boolean; // set when the map has been cleared
		private var world 			 : World; // just so we can call addObject in the loadMap method.		
		
		
		public function Map( w : World, map : String )
		{
			world = w;
			
			// Initialize the array.
			for( var i : int = 0; i < cells.length; ++i)
			{
				cells[i] = new Cell( null, true);
			}
			
			// Load the map itself.
			loadMap(map);			
		}
		
		
		public function update() : void
		{
			// Look for detached balls and make them fall off the map.
			updateBalls();
			
			// Update the array of allowed ball types, because we should only
			// let the cannon spawn ball types that exist in the map right now.
			updateAllowedBallTypes();

		}
		
		
		public function hasWon() : Boolean
		{
			return won;
		}
		
		
		public function getAllowedBallTypes() : Array
		{
			return allowedBallTypes;
		}
		
		
		// Return the number of hex rows in the map.
		public function getCellCountY() : int
		{
			return MAX_HEIGHT;
		}
		
		
		// Return the length of a given hex row.   
		public function getCellCountX( j : int ) : int
		{
			var odd : Boolean = (j & 1) == 1;
			return odd ? MAX_WIDTH - 1 : MAX_WIDTH;
		}
		
		
		// Return the x screen position for the given hex coordinates.
		public function getX( i : int, j : int ) : void
		{
			var odd : Boolean = (j & 1) == 1;
			return 16 + i * COLUMN_WIDTH + (odd ? 16 : 0);
		}
		
		
		// Return the y screen position for the given hex coordinates.
		public function getY( i : int, j : int) : void
		{
			return 16 + j * ROW_HEIGHT;
		}
		
		
		// Put a ball at a given set of hex coordinates. 
		// Also check if it matches any neighboring balls, and make them fall if so.
		public function setBall( i : int, j : int, ball : Ball ) : void
		{
			var c : Cell = getCell(i,j);
			
			if(c == null || c.ball != null)
			{
				return;
			}
			
			c.ball = ball;
			
			handleMatches(i,j);
		}
		
		
		// Return the map entry for the given hex coordinates, or null.
		public function getCell( i : int, j : int) : Cell
		{
			if(i < 0 || j < 0 || i >= getCellCountX(j) || j >= getCellCountY())
			{
				return null;
			}
			
			return cells[i + j * MAX_WIDTH];
		}
		
		
		// Load a map and spawn balls etc.
		private function loadMap( map : String ) : void
		{
			// Lookup table for the string-based maps.
			var lookups : String = "0123456789 "; 
			
			// Clear out spaces.
			map = map.replace( " ", "" );
			
			// Loop over how many balls or spaces are expected.
			var ci : int = 0;
			for( var j : int = 0; j < getCellCountY(); ++j)
			{
				for( var i : int = 0; i < getCellCountX(j); ++i)
				{
					// Stop if the map text ends.
					if(ci >= map.length())
					{
						return;
					}
					
					// Translate the character in the map string to a ball type.
					var type : int = lookups.indexOf(map.charAt(ci++));
					
					// If it's a valid type, spawn a ball.
					if(type >= 0 && type < Ball.typeCount)
					{
						// Add the ball to the world.
						var ball : Ball = new Ball(type);
						world.addObject( ball, getX(i,j), getY(i,j));
						
						// And to the map. (Don't use setBall(i,j,ball) as this will cause matches!)
						getCell(i,j).ball = ball;
					}
				}
			}
		}		
		
		
		// Given the position of a new ball, find matching ones and make them fall off the playfield.
		private function handleMatches( i : int, j : int ) : void
		{
			// Generate a list of matching balls.
			// cambiar a diccionariosss!!
			var matches : Array = new Array();
			
			// Recursively find matching balls among the neighbors.
			match( i,j, matches);
			
			// If we got >= 3 matches, clear them!
			if( matches.size() >= 3)
			{
				for( var c : Cell in matches )
				{
					world.addObject( new StickEffect(), c.ball.x, c.ball.y );
					c.ball.fall();
					c.ball = null;
				}
			}
		}
		
		
		// Recursively match a ball and same-colored neighbors.
		private function match( i : int, j : int, matches : Array ) : void
		{
			var c : Cell = getCell( i, j );
			
			// Skip empty space or space outside map.
			// And don't add one that's already been matched.
			if( c == null || c.ball == null || matches.contains(c))
			{
				return;
			}
			
			// Match this ball if it has the same type as the ones already matched.
			if( matches.isEmpty() || c.ball.type == matches.get(0).ball.type )
			{
				// Record it.
				matches.add(c);
				
				// Left/right neighbors.
				match(i-1, j, matches);
				match(i+1, j, matches);
				
				// Odd and even rows have their diagonal neighbors positioned differently in i,j coordinates.
				if((j & 1) == 1) // odd row
				{
					match(i, j-1, matches);
					match(i+1, j-1, matches);
					match(i, j+1, matches);
					match(i+1, j+1, matches);
				}
				else // even row
				{
					match(i-1, j-1, matches);
					match(i, j-1, matches);
					match(i-1, j+1, matches);
					match(i, j+1, matches);
				}
			}
		}
		
		
		// Update the 'allowedBallTypes' array based on what is in the map.
		// Note: This is complicated but avoids O(n*m) search.
		public function updateAllowedBallTypes():void
		{
			var allowedCount : int = 0;
			var allowed : Array = new Array();
			
			// Only ball types that exist in the map RIGHT NOW as attached balls will be allowed.
			for( var c : Cell in cells )
			{
				if( c != null && c.ball != null && c.attached )
				{
					var type : int = c.ball.type;
					
					if( !allowed[type] ) allowedCount++;
					
					allowed[type] = true;
				}
			}
			
			/*
			allowedBallTypes = new int[allowedCount];
			var writeIndex : int = 0;
			for(int type = 0; type < Ball.typeCount; ++type)
			{
				if( allowed[type] )
				{
					allowedBallTypes[writeIndex++] = type;
				}
			}		
			*/
		}

		
		private function updateBalls() : void
		{
			// Mark all balls as unattached.
			for( var c : Cell in cells )
			{
				c.attached = false;
			}
			
			// Find the balls attached to the top edge of the map, and scan ALL their neighbors recursively.
			// This will cause a flood fill of the "attached" flag. Any balls NOT reached by this fill
			// should be cleared away.
			for( var i : int = 0; i < getCellCountX(0); ++i)
			{
				var c : Cell = cells[i];
				
				if( c.ball != null)
				{
					markAttached(i,0);
				}
			}
			
			// Clear any balls that don't have the attached flag set.
			// ALSO set the 'won' attribute if the game was won (== no attached balls on the map).
			won = true;
			
			for( var c : Cell in cells)
			{
				if( c != null && c.ball != null)
				{
					if(c.attached)
					{
						won = false;
					}
					else
					{
						c.ball.fall();
						c.ball = null;
					}
				}
			}
		}
		
		private function markAttached( i : int, j : int ) : void
		{
			var c : Cell = getCell(i,j);
			
			// Don't continue with:
			// 1) Invalid cells 
			// 2) Empty cells
			// 3) Already attached cells
			if(c == null || c.ball == null || c.attached )
			{
				return;
			}
			
			c.attached = true;
			
			// Left/right neighbors.
			markAttached(i-1, j);
			markAttached(i+1, j);
			
			// Odd and even rows have their diagonal neighbors positioned differently in i,j coordinates.
			if((j & 1) == 1) // odd row
			{
				markAttached(i, j-1);
				markAttached(i+1, j-1);
				markAttached(i, j+1);
				markAttached(i+1, j+1);
			}
			else // even row
			{
				markAttached(i-1, j-1);
				markAttached(i, j-1);
				markAttached(i-1, j+1);
				markAttached(i, j+1);
			}
		}
		
		// Return the nearest free space to the specified pixel coordinates.
		public  function findFreeCell( x : int, y : int ) : Position
		{
			// Linear search through the map, just return the closest map entry position.
			// This could be more efficient.
			var minDistance : Number = Double.MAX_VALUE;
			var pos : Position = null;
			
			for( var j : int = 0; j < getCellCountY(); ++j)
			{
				for( var i : int = 0; i < getCellCountX(j); ++i)
				{
					var c : Cell = getCell( i,j );
					
					// Only consider empty cells.
					if(c != null && c.ball == null)
					{
						var dx : Number = getX(i,j) - x;
						var dy : Number = getY(i,j) - y;
						var distance : Number = dx*dx+dy*dy;
						
						if(distance < minDistance)
						{
							minDistance = distance;
							
							if(pos == null)
							{
								pos = new Position();
							}
							
							pos.i = i;
							pos.j = j;
						}
					}
				}
			}
			
			// Return the position (or null if none found)
			return pos;
		}
		
	}
}