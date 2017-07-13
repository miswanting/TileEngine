package
{
	import flash.events.Event;
	import flash.display.*;
	
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
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.nativeWindow.x = 0;
			stage.nativeWindow.y = 0;
			stage.nativeWindow.width = 1366;
			stage.nativeWindow.height = 768;
			//stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE
			// entry point
			graphics.beginFill(0x777777);
			graphics.drawRect(0, 0, stage.nativeWindow.width, stage.nativeWindow.height);
			var game:Game = new Game();
			addChild(game);
			//var net:Net = new Net();
		}
		
		private function loop(e:Event):void
		{
		}
	
	}

}