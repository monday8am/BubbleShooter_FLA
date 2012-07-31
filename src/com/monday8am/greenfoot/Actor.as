package com.monday8am.greenfoot
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Actor extends MovieClip
	{
		
		private var _world : World;
		
		
		public function Actor()
		{
			super();
		}
		
		
		protected function addedToWorld( world : World ):void
		{
			_world = world;
		}
		
		
		public function getWorld():World
		{
			// TODO Auto Generated method stub
			return _world;
		}		
		
		
		public function setRotation( angle : int ):void
		{
			this.rotation = angle;
		}
		
		
		public function getX():int
		{
			return this.x;	
		}
		
		
		public function getY():int
		{
			return this.y;	
		}
		
		
		public function getWidth():int
		{
			return this.width;	
		}
		
		
		public function getHeight():int
		{
			return this.height;	
		}
		
		
		public function getImage() : void
		{	
			return this;
		}
		
		
		public function getIntersectingObjects( className : String ) : Array 
		{
			var result : Array = new Array();
			
			for (var i:int = 0; i < _world.numChildren; i++) 
			{
				var child : DisplayObject = _world.getChildAt( i );
				
				if( getQualifiedClassName( child ) == className && child != this )
				{
					if( child.hitTestObject( this ) == true )
					{
						result.push( child );
					}
				}					
			}

			
			return result;
		}
		
		
		public function setLocation( x : int, y : int ) : void
		{
			// set location
			this.x = x;
			this.y = y;
		}
		


	}
}