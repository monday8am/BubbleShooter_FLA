package game
{
	
	public class Cell
	{

		private var _ball     : Ball;
		private var _attached : Boolean;
		
		
		public function Cell( ball : Ball,  attached : Boolean )
		{
			_ball = ball;
			_attached = attached;
		}

		
		public function get attached():Boolean
		{
			return _attached;
		}

		
		public function set attached(value:Boolean):void
		{
			_attached = value;
		}

		
		public function get ball():Ball
		{
			return _ball;
		}

		
		public function set ball(value:Ball):void
		{
			_ball = value;
		}

	}
}