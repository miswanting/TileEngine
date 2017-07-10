package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Main extends Sprite
	{
		
		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			// entry point
			var game:Game = new Game();
			addChild(game);
			//var net:Net = new Net();
		
		}
		
		private function loop(e:Event):void
		{
		}
	
	}

}