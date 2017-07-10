package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class PopupMsg extends Sprite
	{
		public var defaultTime:int = 100;
		
		private var msgs:Array = new Array();
		
		public function PopupMsg()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			// entry point
		}
		
		private function loop(e:Event):void
		{
			for (var i:int = 0; i < msgs.length; i++)
			{
				if (i < msgs.length - 1)
				{
					msgs[i].text.y--;
					if (msgs[i].text.hitTestObject(msgs[i + 1].text))
					{
						msgs[i].text.y++;
					}
					if (msgs[i].text.hitTestObject(msgs[i + 1].text))
					{
						msgs[i].text.y++;
					}
				}
				else
				{
					msgs[i].text.y--;
					if (msgs[i].text.y < 0)
					{
						msgs[i].text.y++;
					}
				}
				if (msgs[i].time <= 0)
				{
					removeChild(msgs[i].text)
					msgs.removeAt(i)
				}
				else
				{
					msgs[i].time--;
				}
			}
		}
		
		public function send(text:String, time:int = 0):void
		{
			if (time == 0)
			{
				time = this.defaultTime
			}
			var newPopupMsg:Object = new Object;
			var newText:TextField = new TextField;
			newText.text = text;
			newText.background = true;
			newText.border = true;
			newText.autoSize = TextFieldAutoSize.LEFT;
			addChild(newText)
			newPopupMsg.text = newText;
			newPopupMsg.time = time;
			msgs.push(newPopupMsg)
		}
	
	}

}