package com.monday8am.greenfoot
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Greenfoot extends EventDispatcher
	{
		
		// greenfot instance variables
		
		private var _keyPressed : Object = new Object();
		
		private var _speed   : int = 100;
		
		private var _started : Boolean = false;

		private var _timer	 : Timer;
		
		private var _world   : World;

		
		// singleton...
		
		private static var _instance : Greenfoot;			
		
		
		public static function get instance() : Greenfoot 
		{
			if ( _instance == null) 
			{
				_instance = new Greenfoot( new SingletonEnforcer() );

			} 
			return _instance;
		}
		
		
		/*
		* Model constructor.
		*/
		
		public function Greenfoot( pvt:SingletonEnforcer ) 
		{
			super();

			// timer 
			
			_timer = new Timer( _speed, 0 );
			_timer.addEventListener( TimerEvent.TIMER, onTimerEvent );
		}		
		
		
		public function init( mainView : Sprite ):void
		{		
			// keyboard
				
			mainView.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			mainView.stage.addEventListener( KeyboardEvent.KEY_UP  , onKeyUp   );
			
			_keyPressed[ "left"  ]  = false;
			_keyPressed[ "up"   ]  = false;
			_keyPressed[ "right" ]  = false;				
		}
		
		
		public function restartSpeed():void
		{
			if( _timer != null ) 
			{
				_timer.removeEventListener( TimerEvent.TIMER, onTimerEvent );
				_timer.stop();
				_timer = null;
			}
			
			_timer = new Timer( _speed, 0 );
			_timer.addEventListener( TimerEvent.TIMER, onTimerEvent );	
			_timer.start();
			
			_started = true;
		}
		
		/**
		 * 
		 *  Static methods
		 * 
		 */ 

		
		public static function getRandomNumber( len : int ) : int
		{
			return 0;
		}
	
		
		public static function playSound( sound : String ) : void
		{
			
		}
		
		
		public static function isKeyDown( keyName : String ) : Boolean
		{
			trace( instance._keyPressed[ keyName ], keyName );
			return instance._keyPressed[ keyName ];
		}
		
		
		public static function setWorld( world : World ) : void
		{
			instance._world = world;
		}		
		
		
		public static function setSpeed( speed : int ):void
		{
			instance._speed = speed;
			
			instance.restartSpeed();
		}
		
		
		public static function start():void
		{
			instance._timer.start();
			
			instance._started = true;
		}		
		
		
		public static function stop():void
		{
			instance._timer.stop();
			
			instance._started = false;
			
		}
		
		
		/**
		 * 
		 * 
		 */
		
		private function onTimerEvent( event:TimerEvent ):void
		{
			if( _world == null ) return;
			
			_world.act();
			
			for (var i:int = 0; i < _world.getObjects().length; i++) 
			{
				_world.getObjects()[i].act();		
			}
			
			
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{

			if( event.keyCode == 37 )
			{
				_keyPressed[ "left" ]  = false;
			}
			else if ( event.keyCode == 38)
			{
				_keyPressed[ "top" ] = false;
			}
			else if ( event.keyCode == 39)
			{
				_keyPressed[ "top" ]   = false;	
			}
				
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{

			if( event.keyCode == 37 )
			{
				_keyPressed[ "left" ]  = true;
			}
			else if ( event.keyCode == 38)
			{
				_keyPressed[ "top" ] = true;
			}
			else if ( event.keyCode == 39)
			{
				_keyPressed[ "top" ]   = true;	
			}			
			
		}		

	}
}

internal class SingletonEnforcer { }