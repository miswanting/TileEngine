package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Creature extends Sprite
	{
		public var up:Point, ap:Point, rp:Point, dp:Point;
		private var map:Map;
		
		public var rx:Number = 0; // 相对于地图的位置（以Block计）
		public var ry:Number = 0;
		public var tx:int = 0; // 目标Block
		public var ty:int = 0;
		
		public var currentOnTile:Array = new Array(0, 0);
		public var nextTileToGo:Array = new Array(0, 0);
		public var _path:Array = new Array;
		
		public function Creature(map:Map)
		{
			this.map = map;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			// entry point
			draw()
		}
		
		private function loop(e:Event):void
		{
			if (tx - rx != 0)
			{
				rx += (tx - rx) / Math.abs(tx - rx) / map.tileLength;
				if ((tx - rx) / Math.abs(tx - rx) < 0.5)rx = tx;
			}
			if (ty - ry != 0)
			{
				ry += (ty - ry) / Math.abs(ty - ry) / map.tileLength;
				if ((ty - ry) / Math.abs(ty - ry) < 0.5)ry = ty;
			}
			x = map.x + rx * map.tileLength;
			y = map.y + ry * map.tileLength;
			checkInTile();
		}
		
		private function draw():void
		{
			this.graphics.beginFill(0x0000ff)
			this.graphics.drawCircle(50 / 2, 50 / 2, 50 / 2);
		}
		
		private function checkInTile():void
		{
			// 算出现在的Tile
			var nowX:int = int(rx + 0.5);
			var nowY:int = int(ry + 0.5);
			// 比较
			if (currentOnTile[0] != nowX || currentOnTile[1] != nowY)
			{
				currentOnTile = [nowX, nowY];
				changeOnTile();
			}
		}
		
		private function changeOnTile():void
		{
			if (path.length > 0)
			{
				if (currentOnTile[0] == nextTileToGo[0] && currentOnTile[1] == nextTileToGo[1])
				{
					nextTileToGo = _path.shift();
					tx = nextTileToGo[0];
					ty = nextTileToGo[1];
				}
			}
		}
		
		public function set path(p:Array):void
		{
			_path = p;
			nextTileToGo = path.shift();
			tx = nextTileToGo[0];
			ty = nextTileToGo[1];
		}
		
		public function get path():Array
		{
			return _path;
		}
	}

}