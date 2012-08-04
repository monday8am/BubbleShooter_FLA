package game
{
	
	import com.monday8am.greenfoot.Greenfoot;
	import com.monday8am.greenfoot.World;
	
	import flash.display.MovieClip;
	
	public class Cannon extends SmoothActor
	{
		
		private var waitingForBall : Boolean = false;
		
		private static const ANGULAR_SPEED : Number = 0.9; // how many degrees we turn per 1/100th second.
		private static const MAX_ANGLE 	   : Number= 80; // how far we can rotate the cannon in either direction.
		
		private var angle : Number = 0; 	// current floating-point angle. we want high precision.
		private var ball : Ball = null; 	// ball "owned" by the cannon (until it hits the map).
		private var wasUpPressed : Boolean = false; // key-release tracking variable (see below).
		
		
		public function Cannon()
		{
			super();
			
			// Set image
			
			var cannon : MovieClip = new cannon_mc();
			setImage( cannon );				
		}
		
		
		override protected function addedToWorld( world : World ) : void
		{
			// We're in the world, so prepare the first ball.
			prepareBall();
		}	
		
		
		public function prepareBall() : void
		{
			// Get a random ball type from the list of allowed ones. Only balls currently in the map
			// will be in the list.
			var allowedBallTypes : Array = BubbleWorld( getWorld() ).getMap().getAllowedBallTypes();
			
			if ( allowedBallTypes.length > 0) 
			{
				var type : int = allowedBallTypes[ Greenfoot.getRandomNumber( allowedBallTypes.length ) ];
				
				// Create it and add it to the world.
				ball = new Ball(type);
				getWorld().addObject( ball, getX(), getY() );
			}
		}		
		

		private function fireBall() : void
		{
			// Play sound when the ball is fired.
			Greenfoot.playSound("fire.wav");
			
			// Get the ball moving and begin waiting for it to hit something.
			ball.move( angle );
			waitingForBall = true;
		}

		
		override public function doIt( deltaTime : Number ) : void
		{
			// Handle key presses.
			handleKeys( deltaTime );
			
			// If we're waiting for our moving ball to hit something, and it now stopped moving...
			var ballFinishedMoving : Boolean = ( ball.state != Ball.STATE_MOVING );
			
			if( waitingForBall && ballFinishedMoving)
			{
				// Stop waiting and load up a new ball.
				waitingForBall = false;
				prepareBall();
			}
		}	
		
		
		private function handleKeys( deltaTime : Number ) : void
		{   
			// Player presses the UP arrow: fire a ball if we're ready.
			// Note: The extra code is to ensure that the player releases the key before
			// firing again. Greenfoot lacks a better way to do it.
			var isUpPressed : Boolean = Greenfoot.isKeyDown( "up" );
			
			if( isUpPressed && !wasUpPressed && !waitingForBall )
			{
				fireBall();
			}
			
			// Save the current up-key-pressed state for next time.
			wasUpPressed = isUpPressed;
			
			// Player presses the LEFT arrow: turn the cannon left.
			if( Greenfoot.isKeyDown( "left" ) )
			{
				angle = Math.max( -MAX_ANGLE, angle - ANGULAR_SPEED * deltaTime);
				setRotation( int(angle) );
			}
			
			// Player presses the RIGHT arrow: turn the cannon right.
			if( Greenfoot.isKeyDown("right") )
			{
				angle = Math.min(MAX_ANGLE, angle + ANGULAR_SPEED * deltaTime);
				setRotation( int(angle) );
			}
		}    
		
		
		
	}
}