package
{
	import flash.display.*;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class FakeMovieClip extends Sprite
	{
		// MovieClip模拟
		protected var frames:Array = new Array;
		protected var currentFrame:int = 0;
		
		public function FakeMovieClip()
		{
		
		}
		
		protected function addFrame(shape:Shape, name:String = ""):void
		{
			shape.name = name;
			frames.push(shape);
		}
		
		protected function gotoAndStop(frame:int):void
		{
			currentFrame = frame;
			graphics.copyFrom(frames[frame].graphics)
		}
		
		protected function gotoAndStopByName(name:String):void
		{
			for (var i:int = 0; i < frames.length; i++)
			{
				if (frames[i].name == name)
				{
					currentFrame = i;
					graphics.copyFrom(frames[i].graphics)
					break;
				}
			}
		}
		
		protected function nextFrame():void
		{
		
		}
		
		protected function prevFrame():void
		{
		
		}
	}

}