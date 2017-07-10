package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Tile extends Sprite
	{
		public var length:Number = 0;
		public var backgoundeColor:uint = 0xffffff;
		public var border:Number = 1;
		public var borderColor:uint = 0x000000;
		public var standable:Boolean = true;
		
		public var mx:int = 0;
		public var my:int = 0;
		public var tx:Number = 0;
		public var ty:Number = 0;
		
		public function Tile(length:Number, backgoundeColor:uint = 0xffffff, border:Number = 1, borderColor:uint = 0x000000):void
		{
			this.length = length;
			this.backgoundeColor = backgoundeColor;
			this.border = border;
			this.borderColor = borderColor;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function config(... args):void
		{
		
		}
		
		public function blinkToTarget():void
		{
			tx = mx * length;
			ty = my * length;
			x = tx;
			y = ty;
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
			tx = mx * length;
			ty = my * length;
			x += (tx - x) / 10;
			y += (ty - y) / 10;
		}
		
		public function draw():void
		{
			this.graphics.beginFill(borderColor)
			this.graphics.drawRect(0, 0, this.length, this.length);
			this.graphics.beginFill(backgoundeColor)
			this.graphics.drawRect(border, border, this.length - 2 * border, this.length - 2 * border);
			var debugText:TextField = new TextField();
			debugText.text = this.mx.toString() + 'x' + this.my.toString();
			debugText.selectable = false;
			addChild(debugText)
			this.cacheAsBitmap = true;
		}
	
	}

}