package
{
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Creature extends Shadow
	{
		
		//protected var mission:
		
		public function Creature(map:Map)
		{
			super(map);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			// entry point
			drawShadow(1);
			drawCreature()
		}
		
		private function loop(e:Event):void
		{
			
			if (moveEfficiency == 0)
			{
				removeChildren();
				addChild(shadow);
				addChild(frames[0]);
			}
			else
			{
				var tmpAngle:Number = faceingangle;
				tmpAngle += 360 / 16;
				if (tmpAngle > 360) tmpAngle -= 360;
				else if (tmpAngle < 0) tmpAngle += 360;
				removeChildren();
				addChild(shadow);
				addChild(frames[int(tmpAngle * 8 / 360) + 1]);
			}
		
		}
		
		private function drawCreature():void
		{
			// 0
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x0000ff);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 25
			v[1] = 0 - map.tileLength / 2;
			v[2] = 0
			v[3] = 50 - map.tileLength / 2;
			v[4] = 50
			v[5] = 50 - map.tileLength / 2;
			newShape.graphics.drawTriangles(v);
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawCircle(25, 0 - map.tileLength / 2, 10);
			addFrame(newShape);
			
			// 1(right)
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x0000ff);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 30
			v[1] = 0 - map.tileLength / 2;
			v[2] = 0
			v[3] = 50 - map.tileLength / 2;
			v[4] = 50
			v[5] = 50 - map.tileLength / 2;
			newShape.graphics.drawTriangles(v);
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawCircle(30, 0 - map.tileLength / 2, 10);
			addFrame(newShape);
			
			// 2(right)
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x0000ff);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 30
			v[1] = 5 - map.tileLength / 2;
			v[2] = 0
			v[3] = 50 - map.tileLength / 2;
			v[4] = 50
			v[5] = 50 - map.tileLength / 2;
			newShape.graphics.drawTriangles(v);
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawCircle(30, 5 - map.tileLength / 2, 10);
			addFrame(newShape);
			
			// 3(right)
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x0000ff);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 25
			v[1] = 5 - map.tileLength / 2;
			v[2] = 0
			v[3] = 50 - map.tileLength / 2;
			v[4] = 50
			v[5] = 50 - map.tileLength / 2;
			newShape.graphics.drawTriangles(v);
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawCircle(25, 5 - map.tileLength / 2, 10);
			addFrame(newShape);
			
			// 4(right)
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x0000ff);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 20
			v[1] = 5 - map.tileLength / 2;
			v[2] = 0
			v[3] = 50 - map.tileLength / 2;
			v[4] = 50
			v[5] = 50 - map.tileLength / 2;
			newShape.graphics.drawTriangles(v);
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawCircle(20, 5 - map.tileLength / 2, 10);
			addFrame(newShape);
			
			// 5(right)
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x0000ff);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 20
			v[1] = 0 - map.tileLength / 2;
			v[2] = 0
			v[3] = 50 - map.tileLength / 2;
			v[4] = 50
			v[5] = 50 - map.tileLength / 2;
			newShape.graphics.drawTriangles(v);
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawCircle(20, 0 - map.tileLength / 2, 10);
			addFrame(newShape);
			
			// 6(right)
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawCircle(20, -5 - map.tileLength / 2, 10);
			newShape.graphics.beginFill(0x0000ff);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 20
			v[1] = -5 - map.tileLength / 2;
			v[2] = 0
			v[3] = 50 - map.tileLength / 2;
			v[4] = 50
			v[5] = 50 - map.tileLength / 2;
			newShape.graphics.drawTriangles(v);
			addFrame(newShape);
			
			// 7(right)
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawCircle(25, -5 - map.tileLength / 2, 10);
			newShape.graphics.beginFill(0x0000ff);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 25
			v[1] = -5 - map.tileLength / 2;
			v[2] = 0
			v[3] = 50 - map.tileLength / 2;
			v[4] = 50
			v[5] = 50 - map.tileLength / 2;
			newShape.graphics.drawTriangles(v);
			addFrame(newShape);
			
			// 8(right)
			var newShape:Shape = new Shape;
			newShape.graphics.beginFill(0x000000);
			newShape.graphics.drawCircle(30, -5 - map.tileLength / 2, 10);
			newShape.graphics.beginFill(0x0000ff);
			var v:Vector.<Number> = new Vector.<Number>(6, true);
			v[0] = 30
			v[1] = -5 - map.tileLength / 2;
			v[2] = 0
			v[3] = 50 - map.tileLength / 2;
			v[4] = 50
			v[5] = 50 - map.tileLength / 2;
			newShape.graphics.drawTriangles(v);
			addFrame(newShape);
			
			addChild(frames[0]);
		}
	
	}

}