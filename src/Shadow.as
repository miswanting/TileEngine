package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Shadow extends Sprite
	{
		private var map:Map;
		
		public var rx:Number = 0; // 相对于地图的位置（像素）
		public var ry:Number = 0;
		public var tx:int = 0; // 目标Block
		public var ty:int = 0;
		
		// 行为学
		public var maxSpeed:Number = 3; // 最高速度。
		public var moveEfficiency:Number = 0; // 移动效率。
		public var maxMoveEfficiency:Number = 1; // 移动效率限制。
		public var faceingangle:Number = 0; // 朝向。右为起点，顺时针角度制。
		
		// 状态机
		public var currentOnTile:Array = new Array(0, 0);
		public var standAccurate:Boolean = true;
		public var nextTileToGo:Array = new Array(0, 0);
		public var _path:Array = new Array;
		public var targetPos:Array = [0, 0];
		
		// 影子
		public var shadow:Shape = new Shape;
		
		public function Shadow(map:Map)
		{
			this.map = map;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			// entry point
			drawShadow(1);
		}
		
		public function drawShadow(rate:Number):void
		{
			shadow.graphics.beginFill(0x000000)
			shadow.graphics.drawEllipse((1 - rate) * map.tileLength / 2, (1 - rate / 2) * map.tileLength / 2, map.tileLength * rate, map.tileLength / 2 * rate);
			addChild(shadow);
		}
		
		private function loop(e:Event):void
		{
			checkInTile();
			// 角度计算
			faceingangle = Math.atan2(ty * map.tileLength - ry, tx * map.tileLength - rx) / Math.PI * 180
			// 角度限制
			if (faceingangle > 360) faceingangle -= 360;
			else if (faceingangle < 0) faceingangle += 360;
			
			// 移动效率计算
			if (Math.pow(targetPos[0] * map.tileLength - rx, 2) + Math.pow(targetPos[1] * map.tileLength - ry, 2) < Math.pow(map.tileLength, 2))
			{
				moveEfficiency = (Math.pow(targetPos[0] * map.tileLength - rx, 2) + Math.pow(targetPos[1] * map.tileLength - ry, 2)) / Math.pow(map.tileLength, 2) + 0.1;
				if (Math.pow(targetPos[0] * map.tileLength - rx, 2) + Math.pow(targetPos[1] * map.tileLength - ry, 2) < Math.pow(maxSpeed * moveEfficiency, 2))
				{
					rx = tx * map.tileLength;
					ry = ty * map.tileLength;
					moveEfficiency = 0;
				}
			}
			else
			{
				moveEfficiency += (maxMoveEfficiency - moveEfficiency) / 15;
			}
			// 移动效率限制
			if (moveEfficiency > maxMoveEfficiency) moveEfficiency = maxMoveEfficiency;
			else if (moveEfficiency < 0) moveEfficiency = 0;
			// 移动处理
			rx += maxSpeed * moveEfficiency * Math.cos(faceingangle / 180 * Math.PI)
			ry += maxSpeed * moveEfficiency * Math.sin(faceingangle / 180 * Math.PI)
			x = map.x + rx;
			y = map.y + ry;
		}
		
		public function moveto(t:Array):void
		{
			var newPath:Array = map.findPath(currentOnTile, t);
			if (newPath.length != 0)
			{
				targetPos = newPath[newPath.length - 1];
				path = newPath;
			}
		}
		
		private function checkInTile():void
		{
			//if (Math.abs(tx * map.tileLength - rx) + Math.abs(ty * map.tileLength - ry) < 1)
			if (Math.pow(tx * map.tileLength - rx, 2) + Math.pow(ty * map.tileLength - ry, 2) < Math.pow(map.tileLength / 4, 2))
			{
				//rx = tx * map.tileLength;
				//ry = ty * map.tileLength;
				standAccurate = true;
			}
			;
			// 算出现在的Tile
			var nowX:int = int((rx + map.tileLength / 2) / map.tileLength);
			var nowY:int = int((ry + map.tileLength / 2) / map.tileLength);
			// 比较
			if ((currentOnTile[0] != nowX || currentOnTile[1] != nowY) && standAccurate)
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
					standAccurate = false;
				}
			}
		}
		
		public function set path(p:Array):void
		{
			_path = p;
			nextTileToGo = path.shift();
			tx = nextTileToGo[0];
			ty = nextTileToGo[1];
			standAccurate = false;
		}
		
		public function get path():Array
		{
			return _path;
		}
	}

}