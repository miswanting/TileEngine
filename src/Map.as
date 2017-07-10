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
			for (var y:int = 0; y < 9; y++)
			{
				tiles[2][y].backgoundeColor = 0xff0000;
				tiles[2][y].standable = false;
				tiles[2][y].draw()
				tiles[7][y + 1].backgoundeColor = 0xff0000;
				tiles[7][y + 1].standable = false;
				tiles[7][y + 1].draw()
			}
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
		
		public function findPath(startP:Array, targetP:Array):Array
		{
			var normalV:Number = 1;
			var diagonalV:Number = Math.sqrt(2);
			var openL:Array = new Array;
			var tmpL:Array = new Array;
			var closeL:Array = new Array;
			var sp:Object, tp:Object;
			function createNode(pos:Array):Object
			{
				var newNode:Object = new Object;
				newNode.x = pos[0];
				newNode.y = pos[1];
				newNode.f = 0;
				newNode.g = 0;
				newNode.h = 0;
				newNode.parent = null;
				return newNode;
			}
			
			if (startP == targetP) return new Array(targetP);
			else if (tiles[startP[0]][startP[1]].standable)
			{
				sp = createNode(startP);
				tp = createNode(targetP);
				openL.push(sp);
				while (openL.length != 0)
				{
					for each (var node:Object in openL)
					{
						node.h = tp.x + tp.y - node.x - node.y;
						node.f = node.g + node.h;
					}
					openL.sortOn("f", Array.NUMERIC);
					var tmp:Object = openL.shift()
					closeL.push(tmp)
					tmpL = new Array;
					for (var x:int = -1; x < 2; x++)
					{
						for (var y:int = -1; y < 2; y++)
						{
							if (tmp.x + x >= 0 && tmp.y + y >= 0 && tmp.x + x < tiles.length && tmp.y + y < tiles[0].length)
							{
								var found:Boolean = false;
								for each (node in closeL)
								{
									if (node.x == tmp.x + x && node.y == tmp.y + y)found = true;
								}
								if (!found)
								{
									var newNode:Object = createNode([tmp.x + x, tmp.y + y])
									if (Math.abs(x) + Math.abs(y) == 1)newNode.g = tmp.g + normalV;
									else newNode.g = tmp.g + diagonalV;
									newNode.parent = tmp;
									tmpL.push(newNode);
								}
							}
						}
					}
					for each (node in tmpL.concat())
					{
						if (Math.abs(node.x - tmp.x) + Math.abs(node.y - tmp.y) == 1 && !tiles[node.x][node.y].standable)
						{
							if (Math.abs(node.x - tmp.x) == 1)
							{
								for (var i:int = 0; i < tmpL.length; i++)
								{
									if (tmpL[i].x == node.x)
									{
										tmpL.removeAt(i);
										i--;
									}
								}
							}
							else if (Math.abs(node.y - tmp.y) == 1)
							{
								for (var i:int = 0; i < tmpL.length; i++)
								{
									if (tmpL[i].y == node.y)
									{
										tmpL.removeAt(i);
										i--;
									}
								}
							}
						}
						else if (!tiles[node.x][node.y].standable)
						{
							for (var i:int = 0; i < tmpL.length; i++)
							{
								if (tmpL[i].x == node.x && tmpL[i].y == node.y)
								{
									tmpL.removeAt(i);
									i--;
								}
							}
						}
					}
					for (var i:int = 0; i < openL.length; i++)
					{
						for (var j:int = 0; j < tmpL.length; j++)
						{
							if (tmpL[j].x == tp.x && tmpL[j].y == tp.y)
							{
								var answer:Array = new Array;
								var currentNode:Object = tmpL[j];
								answer.push([tmpL[j].x, tmpL[j].y])
								while (true)
								{
									if (currentNode.parent)
									{
										currentNode = currentNode.parent;
										answer.push([currentNode.x, currentNode.y])
									}
									else break;
								}
								answer.pop()
								answer.reverse()
								return answer
							}
							if (openL[i].x == tmpL[j].x && openL[i].y == tmpL[j].y)
							{
								if (openL[i].g > tmpL[j].g)openL.removeAt(i);
								else tmpL.removeAt(j);
							}
						}
					}
					for each (var item:Object in tmpL)openL.push(item);
				}
			}
			else return new Array(targetP);
			return new Array;
		}
		
		private function generateMap():void
		{
			for (var mx:int = 0; mx < 10; mx++)
			{
				var yTiles:Array = new Array();
				for (var my:int = 0; my < 10; my++)
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
		}
	
	}

}