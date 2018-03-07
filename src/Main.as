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
			var offsetX:Number = stage.nativeWindow.width - stage.stageWidth;
			var offsetY:Number = stage.nativeWindow.height - stage.stageHeight;
			stage.nativeWindow.width = 1366 + offsetX;
			stage.nativeWindow.height = 768 + offsetY;
			stage.nativeWindow.x = (Screen.mainScreen.bounds.width - stage.nativeWindow.width) / 2;
			stage.nativeWindow.y = (Screen.mainScreen.bounds.height - stage.nativeWindow.height) / 2;
			//stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE
			// entry point
			trace("程序启动");
			trace('CPU架构：' + Capabilities.cpuArchitecture)
			trace('操作系统：' + Capabilities.os)
			trace('语言：' + Capabilities.languages.join('; '))
			trace('版本：' + Capabilities.version)
			//trace('屏幕尺寸：' + Capabilities.screenResolutionX.toString() + 'x' + Capabilities.screenResolutionY.toString())
			trace('屏幕尺寸：' + Screen.mainScreen.bounds.width.toString() + 'x' + Screen.mainScreen.bounds.height.toString())
			trace('窗口尺寸：' + stage.nativeWindow.width.toString() + 'x' + stage.nativeWindow.height.toString())
			trace('舞台尺寸：' + stage.stageWidth.toString() + 'x' + stage.stageHeight.toString())
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