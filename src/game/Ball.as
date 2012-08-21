package game
{
	import com.monday8am.greenfoot.Greenfoot;
	import com.monday8am.greenfoot.World;
	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	public class Ball extends SmoothActor
	{
		
		public static const typeCount : int = 8; // there are eight ball colors
		
		// List of possible balls. This is static, so they are only loaded once from disk.

		private static const MOVE_SPEED   : Number = 6; // speed when shot from the cannon
		private static const FALL_HSPEED  : int = 3; // horizontal speed (random max)
		private static const FALL_VSPEED  : int     = 10; // initial speed upwards when "falling" (random max)
		private static const FALL_GRAVITY : Number  = 0.12; // gravity acceleration added to the v. speed every act().
		
		// The three states a ball can be in.
		public static const  STATE_MOVING  : int = 0;    // ball is currently moving
		public static const  STATE_STUCK   : int = 1;     // ball is currently stuck on the map
		public static const  STATE_FALLING : int = 2;   // ball is falling off the map
		
		private var _type  	  : int; // color of ball
		private var _state 	  : int = STATE_STUCK; // current state.
		private var exactX 	  : Number; // floating point position for smoothness.
		private var exactY 	  : Number;
		private var velocityX : Number = 0; // floating point velocity.		
		private var velocityY : Number = 0; 
		
		
		public function Ball( color : int )
		{
			super();
			
			_type = color;
			
			// Set the correct image based on the type (color).
			
			var ball : MovieClip = new ball_mc();
			
			// set correct frame using id
			
			ball.gotoAndStop( type);
			
			setImage( ball );	
			
		}
		
		
		public function get state():int
		{
			return _state;
		}

		
		public function get type():int
		{
			return _type;
		}
		
		
		override protected function addedToWorld( world : World ) : void
		{
			// Store the initial position.
			exactX = this.x;
			exactY = this.y;
		}	
		
		
		// stateMoving: Begin moving along the specified angle.
		public function move( angle : Number ) : void
		{
			_state = STATE_MOVING;
			var a : Number = (angle + 270) * Math.PI / 180.0;
			velocityX = Math.cos(a) * MOVE_SPEED;
			velocityY = Math.sin(a) * MOVE_SPEED;
			
			trace( "move : " + angle );
		}
		
		
		// stateStuck: Begin a quiet life just stuck to the map.
		private function stick() : void
		{
			_state = STATE_STUCK;
			
			// Make sure the ball doesn't keep moving.
			velocityX = 0;
			velocityY = 0;
			
			// Ask the map for a free cell near our position.
			var map : Map =  BubbleWorld( getWorld() ).getMap();
			var pos : Position = map.findFreeCell( int(exactX), int(exactY) );
			
			// Set the adjusted x, y.
			exactX = map.getX(pos.i, pos.j);
			exactY = map.getY(pos.i, pos.j);
			
			// Associate the ball with the free map cell.
			map.setBall(pos.i, pos.j, this );
			
			// Spawn an effect.
			getWorld().addObject( new StickEffect(), int( exactX), int( exactY));
			
			// Play sound when the ball sticks to something.
			Greenfoot.playSound("stick.wav");
		}	
		
		
		// stateFalling: Begin to fall off the map.
		public function fall() : void
		{
			_state = STATE_FALLING;
			
			// Set up initial velocities.
			velocityX += ( Greenfoot.getRandomNumber(FALL_HSPEED)/10.0+0.5) * (Greenfoot.getRandomNumber(2)*2-1);
			velocityY -= ( Greenfoot.getRandomNumber(FALL_VSPEED)/10.0+0.5);
		}	
		
		
		private function checkCollisions() : void
		{
			var left  : int = 16;
			var right : int = getWorld().getWidth() - 16;
			
			
			if( exactX < left)
			{
				exactX -= velocityX*2;
				velocityX = -velocityX;
				
				// Play sound when the ball bounces off a wall.
				Greenfoot.playSound("bounce.wav");
			}
			else if( exactX >= right )
			{
				exactX -= velocityX*2;
				velocityX = -velocityX;
				
				// Play sound when the ball bounces off a wall.
				Greenfoot.playSound("bounce.wav");
			}
			
			if( exactY < 16)
			{
				stick();
			}
			else
			{

				var others : Array = getIntersectingObjects( "Ball" );
				// create dictionary
					
				var collisionDistance : Number = Math.pow(32 * 0.82, 2);
				var tooClose : Boolean = false;
				
				
				for (var i:int = 0; i < others.length; i++) 
				{
					var b  : Ball = others[i]; 
					var dx : Number = b.x - this.x;
					var dy : Number = b.y - this.y;
					var d2 : Number = dx*dx + dy*dy;
						
					if( b.state == Ball.STATE_STUCK &&
						d2 <= collisionDistance)
					{
							tooClose = true;
					}
				}
					
				if(tooClose)
				{
					stick();
				}

						
			}
		}	
				
				
		override public function doIt( deltaTime : Number ) : void
		{
			if( state == STATE_MOVING )
			{
				checkCollisions();
				
				exactX += velocityX * deltaTime;
				exactY += velocityY * deltaTime;
				
				setLocation( int( exactX), int( exactY));
			}
			
			else if(state == STATE_FALLING)
				
			{
				velocityY += FALL_GRAVITY * deltaTime;
				exactX += velocityX * deltaTime;
				exactY += velocityY * deltaTime;
				setLocation( int( exactX), int( exactY));   
				
				//if( exactY >= getWorld().getHeight() + getImage().getHeight()/2 )
				if( exactY >= getWorld().getHeight() + getHeight()/2 )
				{
					getWorld().removeObject(this);
				}
			}
			
		} 				
		
			
		
	}
}












			
