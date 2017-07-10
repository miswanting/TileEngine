package
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.events.IOErrorEvent;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Net extends Socket
	{
		
		public function Net()
		{
			super()
			super.connect("localhost", 8765);
			addEventListener(Event.CONNECT, onConnect);
			addEventListener(ProgressEvent.SOCKET_DATA, onData);
			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function onConnect(e:Event):void
		{
			trace("C");
		}
		
		private function onData(e:ProgressEvent):void
		{
			trace("2");
			var str:String = readUTFBytes(bytesAvailable);
			trace(str);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			trace(e);
		}
	}

}