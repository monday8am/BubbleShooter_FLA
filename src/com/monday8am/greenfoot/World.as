package com.monday8am.greenfoot
{
	import flash.display.MovieClip;
	import game.SmoothActor;
	
	public class World extends MovieClip
	{
		
		private var _actorList : Array = new Array();
		
		public function World()
		{
			super();
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