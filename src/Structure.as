package
{
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Structure extends FakeMovieClip
	{
		protected var map:Map = new Map;
		
		public var mx:int = 0; // 相对于地图的位置（tile）
		public var my:int = 0;
		public var rx:Number = 0; // 相对于地图的位置（像素）
		public var ry:Number = 0;
		
		public function Structure(map:Map)
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			this.map = map;
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			// entry point
			drawStructure();
		}
		
		private function loop(e:Event):void
		{
			rx = mx * map.tileLength;
			ry = my * map.tileLength;
			x = rx;
			y = ry;
		}
		
		public function drawStructure():void
		{
			// 0
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawRect(0, 0, map.tileLength, map.tileLength);
			newShape.graphics.beginFill(0x333333);
			newShape.graphics.drawRect(10, 10, map.tileLength - 20, map.tileLength - 20);
			addFrame(newShape, "0");
			
			// unfinished
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x333333);
			newShape.graphics.drawRect(0, 0, map.tileLength, map.tileLength);
			addFrame(newShape, "unfinished");
			
			gotoAndStopByName("0");
		}
	
	}

}