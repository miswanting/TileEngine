package 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class CustomEvent extends Event 
	{
		static public const MOVE_TO_TARGET:String = "moveToTarget";
		public function CustomEvent(type:String) 
		{
			super(type);
		}
		
	}

}