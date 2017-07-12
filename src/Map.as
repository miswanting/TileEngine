package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Map extends Sprite
	{
		public var tileLength:Number = 50;
		public var tiles:Array = new Array();
		
		public var mx:Number, my:Number; // 以Block计
		public var tx:int, ty:int;
		public var ofX:Number, ofY:Number;
		
		public var mapWidth:Number, mapHeight:Number;
		public var tileXLength:int = 25;
		public var tileYLength:int = 10;
		
		public var diagonalMove:Boolean = true;
		
		public function Map()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			mx = 0;
			my = 0;
			tx = 0;
			ty = 0;
			ofX = 0;
			ofY = 0;
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			// entry point
			generateMap();
			//for (var y:int = 0; y < 9; y++)
			//{
			//tiles[2][y].backgoundeColor = 0xff0000;
			//tiles[2][y].standable = false;
			//tiles[2][y].draw();
			//tiles[7][y + 1].backgoundeColor = 0xff0000;
			//tiles[7][y + 1].standable = false;
			//tiles[7][y + 1].draw();
			//}
		}
		
		private function loop(e:Event):void
		{
			mx += (tx - mx) / 10;
			my += (ty - my) / 10;
			x = ofX - mx * tileLength;
			y = ofY - my * tileLength;
		}
		
		public function blinkToTarget():void
		{
			mx = tx;
			my = ty;
			x = ofX - mx * tileLength;
			y = ofY - my * tileLength;
		}
		
		public function doLeftClick(mouse:Array):void
		{
			var mouseOnTileX:int = int((mouse[0] - x) / tileLength)
			var mouseOnTileY:int = int((mouse[1] - y) / tileLength)
			tiles[mouseOnTileX][mouseOnTileY].backgoundeColor = 0xff0000;
			tiles[mouseOnTileX][mouseOnTileY].standable = false;
			tiles[mouseOnTileX][mouseOnTileY].draw();
		}
		
		public function getMouseOnTilePos(mouse:Array):Array
		{
			return [int((mouse[0] - x) / tileLength), int((mouse[1] - y) / tileLength)];
		}
		
		public function findPath(startP:Array, targetP:Array):Array // 寻路核心
		{
			trace(startP.join("x"), targetP.join("x"));
			// 检测起点合法性。
			if (!tiles[startP[0]][startP[1]].standable)
			{
				trace("[WARN]寻路起点不合法！")
				return new Array;
			}
			
			// 检测终点合法性。
			if (!tiles[targetP[0]][targetP[1]].standable)
			{
				trace("[WARN]寻路终点不合法！")
				return new Array;
			}
			
			// 检测终点是否为起点。
			if (startP[0] == targetP[0] && startP[1] == targetP[1])
			{
				trace("[WARN]寻路终点为寻路起点！")
				return new Array;
			}
			
			// 初始化。
			var straightWeight:Number = 1; // 直走G值增量。
			var obliqueWeight:Number = Math.sqrt(2); // 斜走G值增量。
			var openList:Array = new Array; // 开启列表。
			var candidateList:Array = new Array; // 当前列表。
			var closeList:Array = new Array; // 关闭列表。
			var sp:Object, tp:Object; // 起/终点。
			function createNode(pos:Array, parent:Object = null):Object // 将地图索引值转化为寻路节点。
			{
				var newNode:Object = new Object;
				newNode.x = pos[0];
				newNode.y = pos[1];
				newNode.f = 0; // 总权值
				newNode.g = 0; // 已有权值
				newNode.h = Math.abs(targetP[0] - pos[0]) + Math.abs(targetP[1] - pos[1]); // 还剩权值
				newNode.parent = parent;
				return newNode;
			}
			sp = createNode(startP); // 将起点对象化。
			tp = createNode(targetP); // 将终点对象化。
			openList.push(sp); // 将起点加入OL。
			
			// 开始循环
			while (openList.length != 0)
			{
				// 将OL中F值最小的节点设为当前节点。
				//for each (node in openList) trace("前", node.x, node.y)
				openList.sortOn("f", Array.NUMERIC); // 将OpenList中的各项按照F值从小到大的顺序排序。
				var currentNode:Object = openList.shift() // 拿出OpenList中的F值最小的那一个节点。
				//for each (node in openList) trace("后", node.x, node.y)
				
				// 将当前结点放入CloseList中。
				closeList.push(currentNode)
				
				trace("当前：", currentNode.x, currentNode.y);
				
				// 获取当前节点的合格的四方索引。
				candidateList = new Array;
				for (var x:int = -1; x < 2; x++)
				{
					for (var y:int = -1; y < 2; y++) // 枚举当前tile的周边tile的索引值。
					{
						var indexQualified:Boolean = true;
						var tmpX:int = currentNode.x + x;
						var tmpY:int = currentNode.y + y;
						if (Math.abs(x) + Math.abs(y) == 0) // 排除当前节点。
						{
							indexQualified = false;
						}
						//trace("检查", tmpX, tmpY)
						for each (node in closeList)
						{
							//trace("关闭", node.x, node.y)
							if (node.x == tmpX && node.y == tmpY) indexQualified = false; // 排除已关闭的节点。
						}
						if (tmpX < 0 || tmpY < 0 || tmpX >= tiles.length || tmpY >= tiles[0].length) indexQualified = false; // 排除地图外的节点。
						else
						{
							if (Math.abs(x) + Math.abs(y) == 2)
							{
								if (!tiles[tmpX][currentNode.y].standable || !tiles[currentNode.x][tmpY].standable) indexQualified = false;
							}
							if (!tiles[tmpX][tmpY].standable) indexQualified = false; // 排除不能站的节点。
							
						}
						
						if (indexQualified)
						{
							var newNode:Object = createNode(new Array(tmpX, tmpY), currentNode)
							if (Math.abs(x) + Math.abs(y) == 1) newNode.g = currentNode.g + straightWeight;
							else newNode.g = currentNode.g + obliqueWeight;
							newNode.f = newNode.g + newNode.h;
							//trace("合格：", tmpX, tmpY, newNode.f, newNode.g, newNode.h);
							candidateList.push(newNode)
							
						}
					}
				}
				for each (node in candidateList)
				{
					trace("二", node.x, node.y)
				}
				// 与OpenList进行互动。
				for each (var node:Object in candidateList)
				{
					//trace("take",node.x,node.y)
					var found:Boolean = false;
					for (var i:int = 0; i < openList.length; i++)
					{
						if (openList[i].x == node.x && openList[i].y == node.y)
						{
							found = true;
							if (node.g < openList[i].g)
							{
								openList.removeAt(i);
								//trace("加1", node.x, node.y)
								openList.push(node);
								break;
							}
						}
					}
					if (!found)
					{
						
						//trace("加2", node.x, node.y)
						openList.push(node);
					}
				}
				
				// 检查OpenList中是否有目标格，有则输出。
				for each (node in openList)
				{
					//trace("互动：", node.x, node.y, node.f, node.g, node.h);
					if (tp.x == node.x && tp.y == node.y)
					{
						var answer:Array = new Array;
						var nowNode:Object = node;
						while (true)
						{
							if (nowNode.parent)
							{
								answer.push([nowNode.x, nowNode.y])
								nowNode = nowNode.parent;
							}
							else break;
						}
						answer.reverse()
						return answer;
					}
				}
			}
			return new Array;
		}
		
		private function generateMap():void
		{
			for (var mx:int = 0; mx < tileXLength; mx++)
			{
				var yTiles:Array = new Array();
				for (var my:int = 0; my < tileYLength; my++)
				{
					var tile:Tile = new Tile(tileLength);
					//if (mx == 0 || mx == 9 || my == 0 || my == 9)
					//{
					tile.mx = mx;
					tile.my = my;
					tile.blinkToTarget();
					addChild(tile);
					yTiles.push(tile)
						//}
				}
				this.tiles.push(yTiles)
			}
			mapWidth = tileXLength * tileLength;
			mapHeight = tileYLength * tileLength;
		}
	
	}

}