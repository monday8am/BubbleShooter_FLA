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
		
		
		
		public function World( worldWidth : int, worldHeight : int, cellSize : int, bounded : Boolean )
		{
			super();
			
			_worldWidth = worldWidth;
			
			_worldHeight = worldHeight;
			
			_cellSize = cellSize;
			
			_bounded = bounded;
		}
		
		
		public function addObject( actor : SmoothActor, xPos : int, yPos : int ):void
		{
			// add actor to world
			
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
			// remove actor
		}
		
		
		public function getWidth():int
		{
			return this.width;	
		}
		
		
		public function getHeight():int
		{
			return this.height;	
		}
		
		
	}
}