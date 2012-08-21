package com.monday8am.greenfoot
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Actor extends MovieClip
	{
		
		private var _world : World;
		private var _image : DisplayObject;
		
		
		public function Actor()
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		
		private function onAddedToStage( event:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			_world = World( this.parent )
			
			addedToWorld( _world );
		}		
		
		
		protected function addedToWorld( world : World ):void
		{

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
		
		
		public function getImage() : MovieClip
		{	
			return this;
		}
		
		
		public function setImage( image : DisplayObject ) : void
		{
			_image = image;
			this.addChild( _image );
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
		
		
		public function act():void
		{
			
		}
		


	}
}