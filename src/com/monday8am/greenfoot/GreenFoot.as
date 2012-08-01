package com.monday8am.greenfoot
{
	
	public class Greenfoot
	{
		
		// greenfot instance variables
		
		private var _speed : int = 0;
		

		// singleton...
		
		private static var _instance : Greenfoot;		
		
		
		// singleton 
		
		public static function get instance() : Greenfoot 
		{
			if ( _instance == null) 
			{
				_instance = new Greenfoot( new SingletonEnforcer() );
			} 
			return _instance;
		}	
		
		
		public static function getRandomNumber( len : int ) : int
		{
			return 0;
		}
	
		
		public static function playSound( sound : String ) : void
		{
			// TODO Auto Generated method stub
			
		}
		
		
		public static function isKeyDown( keyName : String ) : Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		
		public static function setSpeed( speed : int ):void
		{
			instance._speed = speed;
		}
		
		
		public static function stop():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}

internal class SingletonEnforcer { }