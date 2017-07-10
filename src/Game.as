package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Game extends Sprite
	{
		public var map:Map = new Map();
		public var man:Man;
		public var debugMsg:PopupMsg = new PopupMsg();
		
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			// entry point
			addChild(map)
			map.ofX = (stage.stageWidth - map.blockLength) / 2;
			map.ofY = (stage.stageHeight - map.blockLength) / 2;
			map.blinkToTarget()
			man = new Man(map);
			addChild(man)
			trace(man.rx, man.ry)
			var debugMsg:PopupMsg = new PopupMsg();
			addChild(debugMsg);
			//debugMsg.send("1", 300)
			//debugMsg.send("2", 200)
			//debugMsg.send("3", 100)
			//debugMsg.send("4", 100)
			//debugMsg.send("5", 200)
			//debugMsg.send("6", 300)
			man.path = map.findPath([0, 0], [9, 9]);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, doKey);
		}
		
		private function loop(e:Event):void
		{
			map.tx = int(man.rx + 0.5);
			map.ty = int(man.ry + 0.5);
		}
		
		private function doKey(e:KeyboardEvent):void
		{
			switch (e.charCode)
			{
			case 119: 
				trace("w");
				man.ty--;
				map.ty--;
				break;
			case 115: 
				trace("s");
				man.ty++;
				map.ty++;
				break;
			case 97: 
				trace("a");
				man.tx--;
				map.tx--;
				break;
			case 100: 
				trace("d");
				man.tx++;
				map.tx++;
				break;
			}
		}
	
	}

}