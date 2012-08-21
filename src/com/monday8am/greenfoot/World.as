package com.monday8am.greenfoot
{
	import flash.display.MovieClip;
	import game.SmoothActor;
	
	public class World extends MovieClip
	{
		
		private var _actorList : Array = new Array();
		
		private var _worldWidth  : int;
		
		private var _worldHeight : int;
		
		private var _cellSize    : int;
		
		private var _bounded     : Boolean;
		
		private var _speed 		 : int; 
		
		
		
		public function World( worldWidth : int, worldHeight : int, cellSize : int, bounded : Boolean )
		{
			super();
			
			_worldWidth = worldWidth;
			
			_worldHeight = worldHeight;
			
			_cellSize = cellSize;
			
			_bounded = bounded;
			
			graphics.lineStyle( 1, 0x000000 );
			
			graphics.drawRect( 0, 0, worldWidth, worldHeight );
			
		}
		
		
		public function addObject( actor : SmoothActor, xPos : int, yPos : int ):void
		{
			
			trace( "add actor " + actor +  " " + _actorList.length );
			
			_actorList.push( actor );
			
			actor.x = xPos;
			
			actor.y = yPos;
			
			addChild( actor );

		}
		
		
		public function getObjects() : Array
		{	
			return _actorList;
		}
		
		
		public function numberOfObjects(): int
		{
			return _actorList.length;
		}
		
		
		public function removeObject( actor : Actor ) : void
		{
			trace( "remove actor ", _actorList.length );
			
			_actorList.splice( _actorList.indexOf( actor), 1 );
			
			removeChild( actor );

		}
		
		
		public function getWidth():int
		{
			return _worldWidth;	
		}
		
		
		public function getHeight():int
		{
			return _worldHeight;	
		}
		
		
		public function act():void
		{
			
		}
		
		
	}
}