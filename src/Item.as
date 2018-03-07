package
{
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Item extends FakeMovieClip
	{
		public static var TREE:String = "Tree";
		
		public var mx:int = 0, my:int = 0;
		
		private var map:Map;
		
		public function Item(map:Map, type:String)
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			this.map = map;
			switch (type)
			{
			case TREE: 
				drawTree();
			}
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			x = mx * map.tileLength;
			y = my * map.tileLength;
		}
		
		public function drawTree()
		{
			var shape:Shape = new Shape;
			shape.graphics.beginFill(0xff0000);
			shape.graphics.drawRect(20, -20, 10, 45);
			shape.graphics.beginFill(0x00ff00);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 25
			v[1] = -25
			v[2] = 0
			v[3] = 0
			v[4] = 50
			v[5] = 0
			shape.graphics.drawTriangles(v);
			graphics.copyFrom(shape.graphics);
		}
	
	}

}